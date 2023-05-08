Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC396F9F33
	for <lists+linux-edac@lfdr.de>; Mon,  8 May 2023 07:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEHFrw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 May 2023 01:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHFrv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 May 2023 01:47:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2068.outbound.protection.outlook.com [40.107.113.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EDC150CE;
        Sun,  7 May 2023 22:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK3i3i9CRlFy2AvoDBvBKk2dcxEC75vfmz/3ZS0vpM+tANz2/Z3WF9/GWOPEBkZu+D3T8ilBlJWSy9vYiTEkrlvSZqH4g9Uv5nWy5/d+l/RRAKNnRpq8Mj6uxZyfk6r8ixrWodpP8etWJ5o0vcJLZFWWOnxcfHpNz+NMlqVaGYtTcie+VTW53bCS26r30VCXw8n5yGPpyhCOCMu0xA1jTh0msrHEb6DDOZbDZJChpBKwA+rGz0S99WHYttAaki2xqikuxCUZBXjsBmk9dUN2Sruge3JO/yVfAxQo+7eDBgWYsqcrlCSqcYYZqg9BTQLMqN5QSSBPW8lKvR3EVjvghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6srNRNKRz3P3B1To2wFU5lAhRQ8laBxOEkYwWS1Sw4c=;
 b=oUCA6TJqd58NXk3f9JDKTuh3aN/lmGoWcb5ANBNt8VrZGPyWxrWp9vBDeBOhM5do0tQtexAifQuZOjRAo7pYow7qoec+qNOo8INxuUYHs2Qxv55sfZbmJo8hV7TYvoB/8NnL5nbi9mlGlC/RstJvpsjyX9E2v7HH7+PqLo/GXcBHow1DXMzrHhFlwQvhcgvR6UVCfZ2d9ewOt1lWwCYMhrhr+E1hN0PW1YDY0OrwCrl6BtG9O2D7dRd87rIvIO1TKksLMmbX7pVC+N8WJ3olHQOyG6tjnX9KLbL8u3b0QcjEP7rqSaUeQlkbiT/FWph/E9LLZ5ARUppeJPdaEgTcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6srNRNKRz3P3B1To2wFU5lAhRQ8laBxOEkYwWS1Sw4c=;
 b=kMDiEziib9gwFEpWHTXZmZqQPSGtakrY6+CWISiPn25IbzmuWIvmjvLx8/vLpMaCIUkERZTxVBWrFIjSnKSsSZ5R4ykvhC36NNgkgwslA6PSFTSGuxJpr3K5pSwwKMc85LPxOWoe4cQfIuBxFfjU7MyQ2mrb3B23dvQsmysGRTA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB10337.jpnprd01.prod.outlook.com (2603:1096:400:251::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 05:47:36 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::15c9:309c:d898:c0f5%3]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 05:47:36 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: Re: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Thread-Topic: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Thread-Index: AQHZgVIgy8kgO6+s7kO2RJLMgjQtp69P3ogA
Date:   Mon, 8 May 2023 05:47:36 +0000
Message-ID: <20230508054734.GA4086583@hori.linux.bs1.fc.nec.co.jp>
References: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TY3PR01MB10337:EE_
x-ms-office365-filtering-correlation-id: a5559b68-5436-49d5-b0f2-08db4f87ba04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5eaAVLxwmr9k+VID2BROnKbwSboPrV6xdma66J3gZQOFJHoRBcBLAoyYcXfIMI3PGNsMNARTDEC/WXkfwQlI/1wjuUrdTXKSw7T8fHPjmgGWggAza5IaQVIYbuKeXVKvdNA+aJB4j0/OQfLVLdtzVheW8GM020RliiNBrWaXWxuiiGCC/6noQiO1hrZ7DYErwYt/2mUF7otU7MpfyJKyoJjkXAd6s5hmwHDwIJZ1s6zOUebjKBPZBbKKp+FbTTOpWXkg6gGmVZ4byQnIOlQp/ocy/uN3VGlW8Yh9cohCITYyvoJo/CQe6AzlUqHqsI/p1JP2LNK5TIoBNxih2kV1Wb7DJBFGc/pqcjQmQw2hoHAyaVlCYFjmgVtfXKEVdA9Y0mMbF7GNklgLdgxntsqpN1oIoHkkDpw3r7SMpbG+22xaHVMKQ5lzyQRDu7/PIRTMuup1E+Ov1wBqK3mrfjT6rCGq+NYGibrA4khrq0dj5bk/Mx+HyASeeE87GqSB9vD1Lg3qHMy7TKGA/pctkM9qr8qNW5iII9MHHoYyMCnLbQTWqufIQ11RTDsJghd82oDD4vgNgYk3L7EQuTrL64meaNX21eYn6hfym+gA5bAQR84oXb6KfrKAWX2ZOCUpyrnp6VwAiSZZec/2mnM9Zkz9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(83380400001)(966005)(6486002)(478600001)(54906003)(71200400001)(9686003)(6512007)(6506007)(1076003)(26005)(186003)(55236004)(85182001)(2906002)(7416002)(33656002)(38100700002)(66476007)(66556008)(66946007)(76116006)(64756008)(6916009)(82960400001)(4326008)(122000001)(41300700001)(66446008)(8676002)(8936002)(38070700005)(86362001)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDc4VFl3amdPODhoS2d6dUI3KzFvTEZtbE8vVGd3NkNhV1JMSGxtOGdwQysz?=
 =?utf-8?B?OTEvYmlURE5hSXhDeFZnc3ZXOTJybkUvWDZrNDNZRFdYN2xQM09GL0cvaEht?=
 =?utf-8?B?UlVNa3ljUmhENFduZVc5K3I1YlA5RnRiZFI1K1g2MFVlcDFycGNsN1V1bzJo?=
 =?utf-8?B?ZWhadVBQZGppbFY4d25sR09YWmVTbTZDeWtlRE1ZdlpnWUU2YjFpTUx3NlVS?=
 =?utf-8?B?SExUWjEwOXFyYzNoQU90aXhXcGplOU1WVVpYd1dmQjlhOVRkQW9lTGU0TXNZ?=
 =?utf-8?B?OC9uS2hIcE4yaFlINUxyQ0tSSzU2TUNWRWtGT002QTBLM1dzSWRZT3cyMWlj?=
 =?utf-8?B?WWJVbk0zRlNPN1ZLcEpPRlJienJ0K3VaS0NiV1ZjZkNQN0p1cXJpbHRQYVo4?=
 =?utf-8?B?M0hPNFRmejBYWjg2b21SUHJZOFVDdEkrVnlPdUJaZ2lqdmQvNzZHeUVEMDBs?=
 =?utf-8?B?UGRhTlJBcnN3dUo4Y2s1U09nWEsxdFdnaUhCU3ZjSFZmN296YXZBKzNNWlpo?=
 =?utf-8?B?bzNyVXdMdFJ5bFFBd2tsblNacEFnMXIyY0NZME1DR0VxZ1pjWXJReE5mTnlL?=
 =?utf-8?B?MHVmd1VZV1B4MDRud1NyREdSR0JpODBiRjdKV0tIMmoyUzRPOTFwcjJSRVhj?=
 =?utf-8?B?YzFSd0pNSmpMdTdLUjNxZ3hnaE43MktYaWJIVkY3a3FOR3doazdRc0JnS0d2?=
 =?utf-8?B?RUl2c1VzbWRSdStzbVRSdmFFN1Z0VkFnejB0ZU5jSklxdi9jQWxHQ1h3bUtJ?=
 =?utf-8?B?aEZ0aUpnOUI2bEtUckxUN05FQnVaWmVzQTcveVQvL0wxUmovMk1Ya2l6NHhK?=
 =?utf-8?B?ZlhxaFR2YzJSTHptNjBXOXJrZW5LTGdaa3RSemVYblJJT1VSL0t2TVpkV3V0?=
 =?utf-8?B?MFpyZGRvZitOQXNEaHdRME01cXNHQXprSEpBTWJxeGFRV3Vta3dSZmE4bk1V?=
 =?utf-8?B?cUQ1T1h2RmpUVjJiaUhYUjZCOGlQaHhUWEQySThjbU9NQWZabFVFNXRjVDhW?=
 =?utf-8?B?YWl1V2hOQmg2S3hFVHoxZW1GUjBOU0lCRERMZldkY0orKzZobVptS21ranFa?=
 =?utf-8?B?M3VndWNSeTJZUFlsOTlnSnJPa2daODBnVDl1RFJQZEhYaGZQRWxaMVoxbis3?=
 =?utf-8?B?cnV5YlcxSDNGWFJZZjlsL1REZi9EK1NxWENDNVQwdzVRcVRPZVQzT0hSYzJk?=
 =?utf-8?B?NCtVMmFTNjY1dDRJQk80Vm1NZHZZdkh2VVU1S3M5WUhPN3N6RE0zcHZIUHVt?=
 =?utf-8?B?VzZVRnRWcFVBRzNpbWNUMzBQc0tzOHp4ZTRlS2dvengrTmc0NFJlNi9tWUJU?=
 =?utf-8?B?ZkRiUzNDMnl6eVpQWkdoM1dhNVlVQ0VZZmFLeWNxK0p0MmdERXhHb2R2WU1E?=
 =?utf-8?B?ZVhlWHRIejJrcTYrd3pja1paeGlFQlFRTUVrei9EbCt2eFJic0hLUXdrQmVY?=
 =?utf-8?B?VG8vS09mRGpWWlZrL0VseWxsYm80cytWWG9pWmpscCtKcG51eHdnL1ZTbGk4?=
 =?utf-8?B?QWZ2L0FJbjRDbExwNHJDN0VYTGVZVW55YlB6NlptbnpkS1BnU2kxL01xaVhm?=
 =?utf-8?B?ZExYWG9pSWJxOTY1SVFwQ3d2dDBIMXNUNEVodE9aR0FsTHVIUHd5M2hldTJJ?=
 =?utf-8?B?YkYyaklsNTkwQXg4MitMcWVYRmkrTkxVVElBdzBpNlYvSjJEWDcyemJReWtv?=
 =?utf-8?B?ajlkak91MjhSd3R3QXkzc1JiRzFyS2ZrWE1oWnNDTUpGT0F4cTFNY3c1Y2NO?=
 =?utf-8?B?Z0pWK1BqSHZiMW1KVHF3cEViSDc4cVBOZWk4Wkw2MTl4Vjl0a0RITjJmelVL?=
 =?utf-8?B?VXVjSkNuOGxCN0RMK2FaNEttSEJrenNNSmRMek13RnUrcCt6NVFPc29kNnFm?=
 =?utf-8?B?V1VMZHhucVRTUlhmc3UzYURqdjcwa2ozVEZpZmRYL3VXS25HeHB3QS9OVFZF?=
 =?utf-8?B?Q2podDc5NDVoOStlWlNKZm51VFBwWmJ0US84V1MyOE1icHMzbnJIR0pSb2VM?=
 =?utf-8?B?ZjV3dUp0eFNNblcxR1IybnVYdE5lbTJjYXVmcHlEbW9scmxhTEliUDZLS2JG?=
 =?utf-8?B?bG8za2pPYmNETHF1VTdGQXI5OUhheVZ5YjVBMDdpWmc1V3lqR1VsbVdsQjQ0?=
 =?utf-8?B?dlBpV29RT0tYblJNZHV5enB5NWpkT1d3dko1RHEvbVJoUnhxWDllanBqRzcv?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8626473D3892784480A7D68D402D77E2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5559b68-5436-49d5-b0f2-08db4f87ba04
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 05:47:36.3019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlG+7kuTnjK7LxYmhk0PG6v9YeBGpCMc4mZpfoOPLpClK0QHX10EzaIXX2nRFONuic+uJ1iJvMXOddV9ndx01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gTW9uLCBNYXkgMDgsIDIwMjMgYXQgMTA6MjI6MzNBTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IEJvdGggRVhfVFlQRV9GQVVMVF9NQ0VfU0FGRSBhbmQgRVhfVFlQRV9ERUZBVUxUX01D
RV9TQUZFIGV4Y2VwdGlvbg0KPiBmaXh1cCB0eXBlcyBhcmUgdXNlZCB0byBpZGVudGlmeSBmaXh1
cHMgd2hpY2ggYWxsb3cgaW4ga2VybmVsICNNQw0KPiByZWNvdmVyeSwgdGhhdCBpcyB0aGUgTWFj
aGluZSBDaGVjayBTYWZlIENvcHkuDQo+IA0KPiBGb3Igbm93LCB0aGUgTUNFX0lOX0tFUk5FTF9D
T1BZSU4gZmxhZyBpcyBvbmx5IHNldCBmb3IgRVhfVFlQRV9DT1BZDQo+IGFuZCBFWF9UWVBFX1VB
Q0NFU1Mgd2hlbiBjb3B5IGZyb20gdXNlciwgYW5kIGNvcnJ1cHRlZCBwYWdlIGlzDQo+IGlzb2xh
dGVkIGluIHRoaXMgY2FzZSwgZm9yIE1DLXNhZmUgY29weSwgbWVtb3J5X2ZhaWx1cmUoKSBpcyBu
b3QNCj4gYWx3YXlzIGNhbGxlZCwgc29tZSBwbGFjZXMsIGxpa2UgX193cF9wYWdlX2NvcHlfdXNl
ciwgY29weV9zdWJwYWdlLA0KPiBjb3B5X3VzZXJfZ2lnYW50aWNfcGFnZSBhbmQga3NtX21pZ2h0
X25lZWRfdG9fY29weSBtYW51YWxseSBjYWxsDQo+IG1lbW9yeV9mYWlsdXJlX3F1ZXVlKCkgdG8g
Y29wZSB3aXRoIHN1Y2ggdW5oYW5kbGVkIGVycm9yIHBhZ2VzLA0KPiByZWNlbnRseSBjb3JlZHVt
cCBod3Bvc2lvbiByZWNvdmVyeSBzdXBwb3J0WzFdIGlzIGFza2VkIHRvIGRvIHRoZQ0KPiBzYW1l
IHRoaW5nLCBhbmQgdGhlcmUgYXJlIHNvbWUgb3RoZXIgYWxyZWFkeSBleGlzdGVkIE1DLXNhZmUg
Y29weQ0KPiBzY2VuYXJpb3MsIGVnLCBudmRpbW0sIGRtLXdyaXRlY2FjaGUsIGRheCwgd2hpY2gg
aGFzIHNpbWlsYXIgaXNzdWUuDQo+IA0KPiBUaGUgYmVzdCB3YXkgdG8gZml4IHRoZW0gaXMgc2V0
IE1DRV9JTl9LRVJORUxfQ09QWUlOIHRvIE1DRV9TQUZFDQo+IGV4Y2VwdGlvbiwgdGhlbiBraWxs
X21lX25ldmVyKCkgd2lsbCBiZSBxdWV1ZWQgdG8gY2FsbCBtZW1vcnlfZmFpbHVyZSgpDQo+IGlu
IGRvX21hY2hpbmVfY2hlY2soKSB0byBpc29sYXRlIGNvcnJ1cHRlZCBwYWdlLCB3aGljaCBhdm9p
ZCBjYWxsaW5nDQo+IG1lbW9yeV9mYWlsdXJlX3F1ZXVlKCkgYWZ0ZXIgZXZlcnkgTUMtc2FmZSBj
b3B5IHJldHVybi4NCj4gDQo+IFsxXSBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMjMwNDE3
MDQ1MzIzLjExMDU0LTEtd2FuZ2tlZmVuZy53YW5nQGh1YXdlaS5jb20NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEtlZmVuZyBXYW5nIDx3YW5na2VmZW5nLndhbmdAaHVhd2VpLmNvbT4NCg0KTG9va3Mg
Z29vZCB0byBtZSwgdGhhbmsgeW91Lg0KDQpSZXZpZXdlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxu
YW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4=
