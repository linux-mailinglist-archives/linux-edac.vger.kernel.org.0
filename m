Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93C39AE5F
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jun 2021 00:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCWuC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Jun 2021 18:50:02 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:13061 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCWuB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 3 Jun 2021 18:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1622760496; x=1654296496;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=6euWPpB9RMCLFG8HoR+UPvFKQ4CrIwpMPDw8qTgPtHE=;
  b=fZvlImqhvNzL8z7IkS6q3zTybsNPBAZPeeAbwQr4hU1VTY/6tGhYwYlx
   zkcbmiDxz++6NH+60HeUYamY+McH2j8QyoGENh7sKiYFQbB/0PQYMhfV3
   2GL0EBMGaaDM5On2GoHVOaYXa2aIomPuLbn1hdKquasJ29tzFWxJiHpWW
   0=;
X-IronPort-AV: E=Sophos;i="5.83,246,1616457600"; 
   d="scan'208";a="936528897"
Subject: Re: [RFC PATCH] x86/mce: Provide sysfs interface to show CMCI storm state
Thread-Topic: [RFC PATCH] x86/mce: Provide sysfs interface to show CMCI storm state
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 03 Jun 2021 22:48:15 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 15E7EA0036;
        Thu,  3 Jun 2021 22:48:13 +0000 (UTC)
Received: from EX13D12UWC004.ant.amazon.com (10.43.162.182) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Thu, 3 Jun 2021 22:48:13 +0000
Received: from EX13D12UWC004.ant.amazon.com (10.43.162.182) by
 EX13D12UWC004.ant.amazon.com (10.43.162.182) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Thu, 3 Jun 2021 22:48:12 +0000
Received: from EX13D12UWC004.ant.amazon.com ([10.43.162.182]) by
 EX13D12UWC004.ant.amazon.com ([10.43.162.182]) with mapi id 15.00.1497.018;
 Thu, 3 Jun 2021 22:48:12 +0000
From:   "BeSerra, Christopher" <beserra@amazon.com>
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Index: AQHXVyGNojI1HFwphkuSoXpNyCJ//ar/nTKAgAABSACAAtL6AA==
Date:   Thu, 3 Jun 2021 22:48:12 +0000
Message-ID: <4B422201-A96F-4EB7-A42F-9A1BF89D4794@amazon.com>
References: <20210601200505.966849-1-tony.luck@intel.com>
 <YLaaLws+4FEHOqQs@zn.tnic> <1cc039a15b4248e1a625dbb6fc275169@intel.com>
In-Reply-To: <1cc039a15b4248e1a625dbb6fc275169@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.110]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EB668A68112FA44A02902B61A65253F@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

VGhlcmUgYXJlIGNvcm5lciBjYXNlcyB3aGVyZSB0aGUgQ0UgY291bnQgaXMgMCB3aGVuIGEgc3Rv
cm0gb2NjdXJzLiAgRURBQyBjb21wbGV0ZWx5IG1pc3NlZCBsb2dnaW5nIENFcy4NCg0K77u/T24g
Ni8xLzIxLCAxOjQxIFBNLCAiTHVjaywgVG9ueSIgPHRvbnkubHVja0BpbnRlbC5jb20+IHdyb3Rl
Og0KDQogICAgQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0
aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCg0KDQoNCiAgICA+IEJ1dCBJJ20gdW5jbGVhciBhcyB0byB3aGF0IHRoaXMgd2hvbGUg
dXNlIGNhc2UgaXMuIFRoZSB2ZXJ5IGZpcnN0DQogICAgPiAiU2NyaXB0cyB0aGF0IHByb2Nlc3Mg
ZXJyb3IgbG9ncyIgYWxyZWFkeSBzb3VuZHMgbGlrZSBhIGJhZCBpZGVhIC0gSSdkDQogICAgPiBl
eHBlY3QgdXNlcnNwYWNlIGNvbnN1bWVycyB0byBvcGVuIHRoZSB0cmFjZV9tY2VfcmVjb3JkKCkg
YW5kIGdldCB0aGUNCiAgICA+IE1DRSByZWNvcmRzIGZyb20gdGhlcmUuIEFuZCBpbiB0aGF0IGNh
c2UgQ01DSSBzdG9ybSBzaG91bGRuJ3QgbWF0dGVyLi4uDQoNCiAgICBJIHRoaW5rIHRoZSBwcm9i
bGVtIGlzIGtub3dpbmcgdGhhdCBtYW55IGVycm9ycyBhcmUgYmVpbmcgbWlzc2VkIGJlY2F1c2UN
CiAgICBvZiB0aGUgc3dpdGNoIHRvIHBvbGwgbW9kZS4gQWxsIG1ldGhvZHMgdG8gdHJhY2sgZXJy
b3JzLCBpbmNsdWRpbmcgdGhlIHRyYWNlX21jZV9yZWNvcmQoKQ0KICAgIHRlY2huaXF1ZSBhcmUg
ZXF1YWxseSBhZmZlY3RlZCBieSBtaXNzZWQgZXJyb3JzLg0KDQogICAgQnV0IG1heWJlIENocmlz
IGNhbiBiZXR0ZXIgZGVzY3JpYmUgd2hhdCB0aGUgcHJvYmxlbSBpcyAuLi4NCg0KICAgIC1Ub255
DQoNCg==
