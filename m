Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1D1362DC
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2020 22:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgAIVyJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 16:54:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:47487 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIVyJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jan 2020 16:54:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 13:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="254738664"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jan 2020 13:54:09 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 13:54:09 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.94]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.88]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 13:54:08 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     =?utf-8?B?SmFuIEguIFNjaMO2bmhlcnI=?= <jschoenh@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Thread-Topic: [PATCH v2 6/6] x86/mce: Dynamically register default MCE
 handler
Thread-Index: AQHVwkeZofp5yuHJHkSd5BxTiwBNgKfaBM4AgAazzICAAF7TAIACRAiA//+NzzA=
Date:   Thu, 9 Jan 2020 21:54:08 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5202EC@ORSMSX115.amr.corp.intel.com>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-7-jschoenh@amazon.de> <20200103220328.GF5099@zn.tnic>
 <BN6PR12MB16670832D78F2799730FB95FF83E0@BN6PR12MB1667.namprd12.prod.outlook.com>
 <20200108100356.GA27363@zn.tnic>
 <BN6PR12MB166720AEED7FE086308BC4ABF8390@BN6PR12MB1667.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB166720AEED7FE086308BC4ABF8390@BN6PR12MB1667.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBJdCBzZWVtcyB0byBtZSB0aGF0IHRoZSBpc3N1ZSBpcyB0aGUgbWNlbG9nIG5vdGlmaWVyIGNv
dW50cyB0b3dhcmQgdGhlIG51bWJlcg0KPiBvZiBub3RpZmllcnMsIHNvIHRoZSBkZWZhdWx0IG5v
dGlmaWVyIGRvZXNuJ3QgcHJpbnQgYW55dGhpbmcuDQoNCklmIHdlIGdhdmUgYSBBUEkgdG8gdGhl
IG5vdGlmaWVycyB0byBzYXkgd2hldGhlciB0byBzdXBwcmVzcyBwcmludGluZywgdGhlbiB0aGUN
CmRldl9tY2Vsb2coKSBjb2RlIGNvdWxkIGRvIHRoZSBzdXBwcmVzc2lvbiBvbmx5IGlmIHNvbWUg
cHJvY2VzcyBoYWQNCi9kZXYvbWNlbG9nIG9wZW4uIFNvIGlmIG1jZWxvZyg4KSB3YXNuJ3QgcnVu
bmluZywgeW91J2Qgc3RpbGwgc2VlIHRoZSBjb25zb2xlDQptZXNzYWdlLg0KDQotVG9ueQ0K
