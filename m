Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E985C30613
	for <lists+linux-edac@lfdr.de>; Fri, 31 May 2019 03:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfEaBPn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 21:15:43 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:29020 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfEaBPm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 May 2019 21:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559265342; x=1590801342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3dcPHAI0Gvq/CrzqlflWGQYcqDQGvQfO4+LTuOCZQf0=;
  b=o1iYe1RCH25ehBM/bk0HZxbeiV7gS9nmkZA8FO7NcKAlEp4S9T1BWZ6+
   DJutdo6TCH8cj0jZFvQkFJNbotDEPntqmxsjXSNfiztNmffFrRYCqW5sk
   7Kg+zTCXDRrjwCkxXY1UGLuRuzMz12UApqnPdiaFK0RPya0cNug7zD8rQ
   M=;
X-IronPort-AV: E=Sophos;i="5.60,533,1549929600"; 
   d="scan'208";a="677322120"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 31 May 2019 01:15:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id CD7CAA22BA;
        Fri, 31 May 2019 01:15:34 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 31 May 2019 01:15:34 +0000
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 31 May 2019 01:15:33 +0000
Received: from EX13D21UWB003.ant.amazon.com ([10.43.161.212]) by
 EX13D21UWB003.ant.amazon.com ([10.43.161.212]) with mapi id 15.00.1367.000;
 Fri, 31 May 2019 01:15:33 +0000
From:   "Herrenschmidt, Benjamin" <benh@amazon.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Shenhar, Talel" <talel@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
Thread-Topic: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
Thread-Index: AQHVFtCyWJ5GzFYeVU2EkxX7Kqkx+qaD+syAgAB0QoA=
Date:   Fri, 31 May 2019 01:15:33 +0000
Message-ID: <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
         <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
         <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
In-Reply-To: <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.73]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3A23C2C906B5342B0BC7E950DEA5E92@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gVGh1LCAyMDE5LTA1LTMwIGF0IDExOjE5IC0wNzAwLCBCb3JpcyBQZXRrb3Ygd3JvdGU6DQo+
IE9uIE1heSAzMCwgMjAxOSAzOjE1OjI5IEFNIFBEVCwgSGFubmEgSGF3YSA8aGhoYXdhQGFtYXpv
bi5jb20+IHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0IGZvciBlcnJvciBkZXRlY3Rpb24gYW5kIGNv
cnJlY3Rpb24gZm9yIEFtYXpvbidzDQo+ID4gQW5uYXB1cm5hDQo+ID4gTGFicyBTb0NzIGZvciBM
MS9MMiBjYWNoZXMuDQo+IA0KPiANCj4gU28gdGhpcyBzaG91bGQgYmUgYSBkcml2ZXIgZm9yIHRo
ZSB3aG9sZSBhbm5hcHVybmEgcGxhdGZvcm0gYW5kIG5vdA0KPiBvbmx5IGFib3V0IHRoZSBSQVMg
ZnVuY3Rpb25hbGl0eSBpbiBhbiBJUCBsaWtlIHRoZSBjYWNoZXMuIFNlZSBvdGhlcg0KPiBBUk0g
RURBQyBkcml2ZXJzIGluIGRyaXZlcnMvZWRhYy8gZm9yIGFuIGV4YW1wbGUuDQoNClRoaXMgaXNu
J3QgdGVycmlibHkgaGVscGZ1bCwgdGhlcmUncyBub3RoaW5nIHRlbGxpbmcgYW55Ym9keSB3aGlj
aCBvZg0KdGhvc2UgZmlsZXMgY29ycmVzcG9uZHMgdG8gYW4gQVJNIFNvQyA6LSkNCg0KVGhhdCBz
YWlkIC4uLg0KDQpZb3UgcmVhbGx5IHdhbnQgYSBzaW5nbGUgRURBQyBkcml2ZXIgdGhhdCBjb250
YWlucyBhbGwgdGhlIHN0dWZmIGZvcg0KdGhlIGNhY2hlcywgdGhlIG1lbW9yeSBjb250cm9sbGVy
LCBldGMuLi4gPw0KDQpUaGUgaWRlYSBoZXJlIHdhcyB0byBzZXBhcmF0ZSB0aGUgY29yZSBMMS9M
MiBFREFDIGZyb20gdGhlIG1lbW9yeQ0KY29udHJvbGxlciBFREFDIEkgdGhpbmsgLi4uIFJvYmVu
LCBIYW5uYSwgY2FuIHlvdSBkZXNjcmliZSB0aGUgbG9uZyBydW4NCnN0cmF0ZWd5IGhlcmUgPw0K
DQpDaGVlcnMsDQpCZW4uDQoNCg==
