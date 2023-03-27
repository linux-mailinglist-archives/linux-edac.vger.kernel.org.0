Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05FD6C9E59
	for <lists+linux-edac@lfdr.de>; Mon, 27 Mar 2023 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjC0Ilh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Mar 2023 04:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjC0Ikp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Mar 2023 04:40:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2071.outbound.protection.outlook.com [40.107.113.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D566EB5;
        Mon, 27 Mar 2023 01:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exMbhNDwdRwkVcHsskDTWZlzwbDzo+WdNaI1PyGbqVeYjHHNKNdOdu+S4Q9AZLQvxjCCKmCqGny3fiZNeYvIZgZLNZtAn8K4l0UDkLcLTA01Zl9KmHamY936ewHKoxRtf2eQsfZ/u1XamXjsWA+nTu2spuU2znMe/iU8jHfIi/fhZTyjOBZg9ocnKxpkBMNTKvSa/cqkPrqSFEvSYD3iv3dL9faoRfjkpWJf8PKhndg6KYNM4N0ApG/sq75ZyvwNvaAdJvnTa70/T57OaeAJZTWBfJx7LxgmSz7U7eO3qf0fdXzZISsC7YLPOnznO+ESFSEst4ijynHFk5xBNscRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+tlBbhcmpdLYS+BB51ef1bAysqIOiZbeH45Frf0ctY=;
 b=j7HXfYhbqxGNOQU5NpWPRa15eGoSjBAzeMOkPfSlDOoBp94wtCoceWZ/pSPC3RpJIH7IE2RA4yqeAgQVh91XnsusXBP3775IWmh5cyeFteOcT3f+qdZNjZM+dj7I3NkDFdfTVD3418CaIwhsY0FMYKPSGDTLqQs42m9maeOMm0LPgtfLIPvdGr4rds2j1H6X4+LenMQZx1FTXAO1xNe6n9iqA2yt90r5ie3mBiqSTtkgVdNiV3rBUEyqNDvOtUp5w1AhSlTBzaCE3VuCr+NOG/EK7rCLHmP4n5B+pmIwGeDlWmzBHC+ZMY4Ol+J1LbGpgWDgozpdTXK/f8Qxw0mGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+tlBbhcmpdLYS+BB51ef1bAysqIOiZbeH45Frf0ctY=;
 b=PscbkP6InfWwW1FJggI6O9uQCugZpn775+UocExnvqEEyUNfmw+RFV8qfcVo7OYAdGbTapzQVfWg/NdNvdWfAzRmkHZU79fIBj8iVSNhn2VLg8m/mvrWVSXADw+ccrZupHjyRe/sj/McINbPrkoHtaacvvnFWrLojFVh8k2snqg=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB10269.jpnprd01.prod.outlook.com (2603:1096:400:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 08:37:42 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8%7]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 08:37:42 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Zhiquan Li <zhiquan1.li@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "youquan.song@intel.com" <youquan.song@intel.com>
Subject: Re: [PATCH v2] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Thread-Topic: [PATCH v2] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Thread-Index: AQHZYFOx/wpQ3foYuECrCxkdDKn8Ga8OTh+A
Date:   Mon, 27 Mar 2023 08:37:41 +0000
Message-ID: <20230327083739.GA956278@hori.linux.bs1.fc.nec.co.jp>
References: <20230327023358.3191922-1-zhiquan1.li@intel.com>
In-Reply-To: <20230327023358.3191922-1-zhiquan1.li@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TY3PR01MB10269:EE_
x-ms-office365-filtering-correlation-id: abb390db-6c33-4fa5-0357-08db2e9e87bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6knoEUr73cSCqJ5vLjOYFT85NqBBGlW7lqyCHkxofV5O6eJAdSgi5VZ5U/izh0rU2OvB9xyiqmjPmfPWwwBh9xQxq5EBVZkDeebA7+jboUDMI4Zn9+NSk3Wa/WrJ1WieFyiLyV6kyU6HuZSmIQ5jAIEaYJAtrW2KSOonhbA5EVJEqUaog2RVHOaiVQ+TY4AvvVHrGsPfgqkhz9CvZd1i7OhC2BIlLLSkl1Ra11D5ktr0+etHpc4zbDucOstg3S13DC93bAaKWhpPCrqjK+Wv/lgM9C5D/om836yaVES2xACBJ5aIpL6ypauoNxfORL0EtTckVaJF/QVM/s2l19dtjd23RVPH+nDcsvhT+o+omIYL9eLT3sNGv7h07yqigme1iHEK2IJXKbAYpiIHOJp9Mhr5NfrtriiY6EQk8BRg5cEH0KgPp5rSwNGfQUN8U+JMn0y0jxC59/XUnGx/rOcPf534wsVRG4g7DeOryFOtI56hv6eoWrf56q9DZ9EYOQZdKWDdomZgtjqe/BcBU+otXnkuIeO7uBU6why4JkGWaGAERawFaUNQV+avkY2A0Hl8TFailx6A1slftXptml4C6lCEPIT+/OK5XS2KtPYc2iSIUTVCt7cvEdeL3pXUiqlg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(9686003)(6512007)(6506007)(1076003)(26005)(55236004)(41300700001)(186003)(6486002)(71200400001)(83380400001)(478600001)(54906003)(316002)(4326008)(38100700002)(2906002)(4744005)(66446008)(64756008)(6916009)(8676002)(76116006)(66476007)(66556008)(66946007)(33656002)(85182001)(38070700005)(82960400001)(86362001)(5660300002)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cy9qRzMxYmkrN0ROMjI5VDIzUENvYlYvUGpTNlRmSEUyMkJGcXF0TS9FajlP?=
 =?utf-8?B?OUJ4Mm9WZmVUZGQ3MGJUbS9jd1pHQU9rbXdLZ1F2eUxhMEhyQ25lUVlEMUpM?=
 =?utf-8?B?akhPODFKNFU3bzBablFDTmllOTJaU3JMWFVrVWQ4WUtEU1ZjaCtyWUZ2N04z?=
 =?utf-8?B?SDFBd2Nha3dIMnRyNlFuQytWY25HUVJCc3ZOSHZZUVp0ZFhjRktzMUNESjB4?=
 =?utf-8?B?bTNOOHp3VmFiNUxGOVI5YWpvMWpTblI1UEtRYnNaQSsweSsxK0FXaEFETlFz?=
 =?utf-8?B?TUI0eDd2OXFVdTd3UStiUWRTTFFoNVArTDN2RjB4a2VydU96OWtIeXBtVFhB?=
 =?utf-8?B?MFBVSExNdkpURXNuZml1TzVQTzZGaXZHc2UydEIvcHBldUxmM3JObDdxekRm?=
 =?utf-8?B?VUpOV3cwbVZ5QTluTHpFaFZUcEV5V3IzMVBzSnI4alNEOG1kTXBURGZ6Z2tD?=
 =?utf-8?B?NithZDZLVllBcmZrTnRzSDJSRm5ZU3hlaFloOXBNYThwYmJYVVRETW93ZEYr?=
 =?utf-8?B?c3A1UzNVRzExWnJ2b3o1d3FsMUlKdFBXcXU3SmdSbTZIdWdzYVJsR0h0K0Rx?=
 =?utf-8?B?TFphaVZmVldYdFF1dFBaOGwxVHhrckVZbEJqS00vTUJyeVhyOEUwZVcvMlo5?=
 =?utf-8?B?Wkp6bnN5amluZ294TFhPOWU1WEVXRVpjVkYxcXdoN3k2V2t3RUxqREtZbExP?=
 =?utf-8?B?MFJWeW5EdnoxbE5rWTQ0cXNQdU4rVFBuL05tRW5KcVY1dVJnTjhGMzg0dStv?=
 =?utf-8?B?YnFzb1prZHBDVk9BUTI3WEJQeEhQMUd3ZVV4dExLMkpYUk8vMkhyQTFjUXVY?=
 =?utf-8?B?WDVNNVZkODJ3QVZrVTl2c0dUcjhCQms3Vjk1ZTAyeWREbklCOWlmZTdmV1dN?=
 =?utf-8?B?ZUV5K3JYSlZaemtSaU5XZWhnbDJPNms4YzduR0RGbnVZVEtwY281ZFBtWDdC?=
 =?utf-8?B?UFM5Sk1Scis0dnc0YmdRRk96MGViT1pWeTNCTStNUWdzTmJJWXlIWDgyUkhZ?=
 =?utf-8?B?OFd5QUxiUFk1cUdLQktMa3QxVjF5SWdoNVlENGdEdHNQb2tkd3dkZW9PaGlt?=
 =?utf-8?B?cjdRTWlBQVp3SEVqWlB5T3hXL2hIR01mcXdrR2pCa0xyY3IwTDBDQmVjVEVp?=
 =?utf-8?B?UEw0WjlWT0RsTkJ0V0hidjdJdWlubGlCZUlOdi9UZ2RSYlUxUi95MUJueVAy?=
 =?utf-8?B?bHgzZ2VPVTdpWlZaWDM1WTBNYzJPbk5yd0xiQ24xQ01RS0Z6V3BVMXRHTWNE?=
 =?utf-8?B?YTRCNjRBdkl1bFJDMHNIckVOQk5jdTVqNnZYUE81b05kZ2czR0NSalIrc0hO?=
 =?utf-8?B?WUMxQWVOZGVGb2ZYZTd2anJvc0E0STQ5bW81TU9nd1c5Z2NWZmprR1RQMWZW?=
 =?utf-8?B?VGVEZmliSXNCaUlrZ09nZ08wSXJhbk1DR2F5RWlWUU13b3FsSnZ1Zm9RRkVT?=
 =?utf-8?B?MVJ0cnJneEZyVm80eXJobE1hbHoxa2gveit4RUY5NUxaTUlBMytsV0ZRTitG?=
 =?utf-8?B?VDM2elphYWVZZWs5NlNldjVoc3oxc3FMRlZrMDEvL3JDd1AzYy9TRXBiWE5K?=
 =?utf-8?B?ajJsZ1QxOFhLYUxsOTdPNDZXeU9kVHJlK0NPL1pFWkk1Kzc3eTVjT29CQ0Jw?=
 =?utf-8?B?eGc3Z09rL0ozUnVDbkV3UFFUd2h0aDQ4RjhWYnI5RjhuenlKdmtwWW9nY1JH?=
 =?utf-8?B?ZFpGYWY0bGdEa2tNUm1QeWFaR0dEbzJUWWJVRWZhR1FwMmhTV012cUd6Mllz?=
 =?utf-8?B?ZW5SUjZXRERYa3lTSSt0eFl0bGJ1eGRGUWZVcEtMSmk1d0xRVzRZeGpRNHAr?=
 =?utf-8?B?RTZQallQTG8rTlowVytKOVF2K2toSkNsRlJpVlNoenM5amdCNlNsMDlVWDJ0?=
 =?utf-8?B?VTg1T3B3RVJBdnMySTdOZjQ4NnJrRWhERzlSRHRYMTJrOFhSL0swc05waDVK?=
 =?utf-8?B?WUc4dy84dUE2MHhLWnJ5WWFycWlGL1JVbytvOXUxQmpkK2IzVVNjcllPRlBH?=
 =?utf-8?B?ZllNblRyTDRhVWtaRmVEcnBzUGsvWVA0YmwrcDlsa3RWdmJLM1NGbHV3STFG?=
 =?utf-8?B?c2hBZ1p6eXZBSVNsWC9OclBIbEh4L0NibzlvZllCMWplRlNxRGl2QWVZdVYw?=
 =?utf-8?B?Mko5RkZIVkVsM2Q2TmdyL0NhQytLM3ZTa2I4ekNodDRxaFdqem85MEhOTnhM?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28CD30D68EE42A43945DF1F77BFC60C3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb390db-6c33-4fa5-0357-08db2e9e87bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 08:37:42.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bg/eCtyNpxlYxEuLcxnFeOQTwvP8Ue819cTySpGzusmSQpr+GjbAn5LsJkh1Ns9CsP6tUIx0AsOj01Do7hikw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10269
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgMTA6MzM6NThBTSArMDgwMCwgWmhpcXVhbiBMaSB3cm90
ZToNCj4gS2R1bXAgY2FuIGV4Y2x1ZGUgdGhlIEhXUG9zaW9uIHBhZ2UgdG8gYXZvaWQgdG91Y2gg
dGhlIGVycm9yIHBhZ2UNCj4gYWdhaW4sIHRoZSBwcmVyZXF1aXNpdGUgaXMgdGhlIFBHX2h3cG9p
c29uIHBhZ2UgZmxhZyBpcyBzZXQuDQo+IEhvd2V2ZXIsIGZvciBzb21lIE1DRSBmYXRhbCBlcnJv
ciBjYXNlcywgdGhlcmUgaXMgbm8gb3Bwb3J0dW5pdHkNCj4gdG8gcXVldWUgYSB0YXNrIGZvciBj
YWxsaW5nIG1lbW9yeV9mYWlsdXJlKCksIGFzIGEgcmVzdWx0LA0KPiB0aGUgY2FwdHVyZSBrZXJu
ZWwgdG91Y2hlcyB0aGUgZXJyb3IgcGFnZSBhZ2FpbiBhbmQgcGFuaWNzLg0KPiANCj4gQWRkIGZ1
bmN0aW9uIG1jZV9zZXRfcGFnZV9od3BvaXNvbl9ub3coKSB3aGljaCBtYXJrcyBhIHBhZ2UgYXMN
Cj4gSFdQb2lzb24gYmVmb3JlIGtlcm5lbCBwYW5pYygpIGZvciBNQ0UgZXJyb3IsIHNvIHRoYXQg
dGhlIGR1bXANCj4gcHJvZ3JhbSBjYW4gY2hlY2sgYW5kIHNraXAgdGhlIGVycm9yIHBhZ2UgYW5k
IHByZXZlbnQgdGhlIGNhcHR1cmUNCj4ga2VybmVsIHBhbmljLg0KPiANCj4gW1Rvbnk6IENoYW5n
ZWQgVGVzdFNldFBhZ2VIV1BvaXNvbigpIHRvIFNldFBhZ2VIV1BvaXNvbigpXQ0KPiANCj4gQ28t
ZGV2ZWxvcGVkLWJ5OiBZb3VxdWFuIFNvbmcgPHlvdXF1YW4uc29uZ0BpbnRlbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFlvdXF1YW4gU29uZyA8eW91cXVhbi5zb25nQGludGVsLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogWmhpcXVhbiBMaSA8emhpcXVhbjEubGlAaW50ZWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQoNCkxvb2tzIGdvb2QgdG8g
bWUsIHRoYW5rIHlvdS4NCg0KUmV2aWV3ZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9y
aWd1Y2hpQG5lYy5jb20+
