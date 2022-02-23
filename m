Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD094C1F46
	for <lists+linux-edac@lfdr.de>; Thu, 24 Feb 2022 00:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbiBWXDv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Feb 2022 18:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiBWXDv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Feb 2022 18:03:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7D357B1A;
        Wed, 23 Feb 2022 15:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645657402; x=1677193402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aMVH7crwy1MB3srdK/n5A3oXFxhJuPPBbjB2BLmCyI0=;
  b=GD25m6G9Jh4SOlcGq7e4KEpklarb0kY06aVzkJnjWa2cK8k8j5LROW8R
   qkE6IFXq/eiudaXeh6n5o4jNvof96F6sIxSMOwe4mcaY1OZ4QZmHpmBfm
   4sokcMxXcigHOJlqdXZz2fTFT7n7gL5eORj3eUCLmK1TolnsNOPzMHI6o
   bpCtgiOj6whuGukXMYkvaBQsODo+O1tORDTvye8iKv7ZgEgW0j7N2Ijkt
   JnaIR4S787X/UUvlQpFPYfYYHPYxQfyoJ+nC3yySlDv3pLzTk+hufk4f3
   msZTDFmiIVt99IAHypdMCVK68w/ieoQQsO0Z6YtSFck0xuAZWoQ4qInAX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="252295442"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="252295442"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="548480859"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2022 15:03:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 15:03:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 15:03:21 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Wed, 23 Feb 2022 15:03:21 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: RE: [RFC PATCH 1/2] x86/mce: Handle AMD threshold interrupt storms
Thread-Topic: [RFC PATCH 1/2] x86/mce: Handle AMD threshold interrupt storms
Thread-Index: AQHYJAj0g3USUdM+TUu4Zg0sbX5umKyX/2gAgAGt9ACACJhKgP//g+Iw
Date:   Wed, 23 Feb 2022 23:03:21 +0000
Message-ID: <ef3e4bd4f8254b42a6d73356b4eec7f8@intel.com>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com> <Yg992OrUbfmtRizs@zn.tnic>
 <3979d97f-464c-e1f4-d648-526b3121dd63@amd.com>
In-Reply-To: <3979d97f-464c-e1f4-d648-526b3121dd63@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBJdCBsb29rcyB0byBtZSBtb3N0IG9mIHRoZSBjb2RlIGNhbiBiZSBzaGFyZWQgZXhjZXB0IGlu
IGZldyBwbGFjZXMNCj4gd2hlcmUgQU1EIGFuZCBJbnRlbCB1c2UgZGlmZmVyZW50IHJlZ2lzdGVy
cyB0byBzZXQgZXJyb3IgdGhyZXNob2xkcy4NCg0KSG9wZWZ1bGx5IGVhc3kgdG8gYWJzdHJhY3Qu
DQoNCj4gQW5kIHRoZSBmYWN0IHRoYXQgQU1EJ3MgdGhyZXNob2xkIGludGVycnVwdHMganVzdCBo
YW5kbGVzIGNvcnJlY3RlZA0KPiBlcnJvcnMgdW5saWtlIENNQ0kuDQoNClRoYXQgbWFrZXMgeW91
ciBsaWZlIG11Y2ggc2ltcGxlciB0aGFuIG1pbmUgOi0pDQoNCj4gSSdtIHRoaW5raW5nIG9mIGNv
bWluZyB1cCB3aXRoIGEgc2hhcmVkIGNvZGUgYmV0d2VlbiBib3RoIGJ5IGtlZXBpbmcNCj4gdGhl
IEludGVsJ3MgbmV3IHN0b3JtIGhhbmRsaW5nIGNvZGUgYXMgYmFzZSBhbmQgaW5jb3Jwb3JhdGlu
ZyBBTUQNCj4gY2hhbmdlcyBvbiB0aGVtIGFuZCBzZW5kIGZvciByZXZpZXcuDQo+DQo+IExldCBt
ZSBrbm93IGlmIHRoYXRzIG9rYXk/DQoNCk15IG5ldyBJbnRlbCBjb2RlIGhhc24ndCBoYWQgQm9y
aXMgbG9vayB0aHJvdWdoIGl0IHlldCB0byBwb2ludA0Kb3V0IGFsbCB0aGUgYml0cyB3aGVyZSBJ
IGhhdmUgYnVncywgb3IganVzdCBtYWtlIHRoaW5ncyBtb3JlIGNvbXBsZXgNCnRoYW4gdGhleSBu
ZWVkIHRvIGJlLg0KDQpTbyBpdCB3b3VsZCBiZSBoZWxwZnVsIGlmIEJvcmlzIGNvdWxkIGRvIGF0
IGxlYXN0IGEgcXVpY2sgc2NhbiB0bw0Kc2F5IG15IGNvZGUgaXMgYSB3b3J0aHkgYmFzZS4gSSdk
IGhhdGUgdG8gc2VlIHlvdSB3YXN0ZSB0aW1lDQpidWlsZGluZyBhIG1lcmdlZCB2ZXJzaW9uIGFu
ZCB0aGVuIGhhdmUgQm9yaXMgc2F5ICJOYWNrIi4NCg0KLVRvbnkNCg==
