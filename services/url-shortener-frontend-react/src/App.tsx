import "bootstrap/dist/css/bootstrap.min.css";
import React from "react";
import "./App.css";
import InputGroup from "react-bootstrap/InputGroup";
import Button from "react-bootstrap/Button";
import Form from "react-bootstrap/Form";
import { validUrl } from "./Utils";
import copy from "copy-to-clipboard";
type AppProps = {};
type AppState = {
  url: string;
  invalidUrl: boolean;
  processing: boolean;
  redirectUrl: string;
  copied: boolean;
};
export default class App extends React.Component<AppProps, AppState> {
  constructor(props: any) {
    super(props);
    this.setState({ url: "", redirectUrl: "" });
  }

  render() {
    return (
      <div>
        <Form className="NewLink">
          <Form.Group className="mb-3">
            <InputGroup>
              <Form.Control
                required
                placeholder="Enter your URL!"
                onChange={this.onLinkChanged}
                isInvalid={this.state?.invalidUrl}
              />
              {!this.state?.processing ? (
                <Button onClick={this.onSubmit}>Submit</Button>
              ) : (
                <Button onClick={this.onSubmit} disabled variant="warning">
                  Processing
                </Button>
              )}
            </InputGroup>
          </Form.Group>
          {this.state?.redirectUrl ? this.renderResult() : null}
        </Form>
      </div>
    );
  }

  renderResult() {
    return (
      <Form.Group className="mb-3" hidden={!this.state?.redirectUrl}>
        <Form.Label>You new URL:</Form.Label>
        <InputGroup>
          <Form.Control readOnly value={this.state?.redirectUrl} />
          {!this.state?.copied ? (
            <Button onClick={this.onCopy} variant="success">
              Copy
            </Button>
          ) : (
            <Button variant="info" disabled>
              Copied!
            </Button>
          )}
        </InputGroup>
      </Form.Group>
    );
  }

  onCopy = () => {
    copy(this.state?.redirectUrl);
    this.setState({ ...this.state, copied: true });
  };

  onLinkChanged = (e: any) => {
    this.setState({ url: e.target.value });
  };

  onSubmit = async (e: any) => {
    if (!this.state?.url) return;
    let { url } = this.state;
    if (!validUrl(url)) {
      this.setState({ ...this.state, invalidUrl: true });
      return;
    }
    this.setState({
      ...this.state,
      invalidUrl: false,
      processing: true,
      redirectUrl: "",
    });
    let response = await fetch("new", {
      method: "post",
      body: JSON.stringify({ url }),
      headers: {
        "content-type": "application/json",
      },
    });
    if (!response.ok) {
      this.setState({ ...this.state, invalidUrl: true, processing: false });
      return;
    }
    let { id } = await response.json();
    let redirectUrl = `${document.location.protocol}//${document.location.host}/${id}`;
    this.setState({
      ...this.state,
      invalidUrl: false,
      processing: false,
      redirectUrl,
      copied: false,
    });
  };
}
