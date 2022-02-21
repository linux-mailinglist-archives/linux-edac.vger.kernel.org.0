Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71F94BD329
	for <lists+linux-edac@lfdr.de>; Mon, 21 Feb 2022 02:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245395AbiBUBcu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 20 Feb 2022 20:32:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiBUBct (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 20 Feb 2022 20:32:49 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2077.outbound.protection.outlook.com [40.107.114.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAC36260;
        Sun, 20 Feb 2022 17:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPyv0nMtecdlDpKCDX8IrzLCunrXvUvKkIx/Uj4qPVudkgAiV/GyFfBfCHVdHibw6nC5znoPv0fqnwLrvvAn9c/Wiq8fqwRap8dp28xBrbynAqj1Y4UuohZsEcD8jIgaNmwjgqZlm3mMfLxQmyO77uQug+N7FIuqQwzfN8LYGLOGCfoXZYi1EjYdTQ1glyn1NJo0nMNgo9KnDWbpVvgw6PPVfJjpXXhyNHUIPvrN2xrw5G/QmujjVMRcgqx4niLtOgSNIQaYN+aBPi2c4Adq3bdXw/qGU68NN1TM9EcbLs6CyHEfwroCnxRa4yGR9iCIG+/OI7BJJlkbPrkksl3KtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5tzyNqNf4iHuC/t2yZbVkjfaxvsdehf8cfhha0E954=;
 b=P7JPJEs9qVAzyGZ7XLBYvwGMMlXUZXkVTQoQ71rP2Jp/V2Thn7gFBl+WEtY3IikdnSNaYy3AuUVlW2H4JQX7KB9DMQEqu6TQmIvoOjKYvRx5kPbGGpAw0RoeVxkbdYxYpx0FZ1cZiKdN/nNKPXcmHOm4KlfBpRoY240bwjyFQEsIi80M1yWTXqcABsKSrVE3JRoLxk5Xv87Ul9dT2bV9wKl8ED5sp4kAuMVSHsJQw4yG2zbkD9SemSFbMz9qXKvym/Z14QF7GxR9J0MbgSrJMoJ0EK/WCwSN2zoI+9jdvLmH30s4I+BKsyHDyzBtet9vtuDKqSQ66ndzQZtqO28kYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5tzyNqNf4iHuC/t2yZbVkjfaxvsdehf8cfhha0E954=;
 b=g4WwoRGV3KRhOLjuuYCy7R8C6AbptFaPwHXrUw3kF4q0MJl+tz2D6OSAolY5QY3ytI56hZp1k3IgYd/+HnHMtt9dRr/jiaJy+5v91s8vNWA6US+NC9cQ5M7RS2OJCvGnnAEdAAxNa5ueuYee2C2NK3wdOrjd2LUAEpo1ef5xfzk=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB3191.jpnprd01.prod.outlook.com (2603:1096:604:16::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.18; Mon, 21 Feb
 2022 01:32:16 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::7c3a:9153:8e79:6a9b%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 01:32:16 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     luofei <luofei@unicloud.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/2] hw/poison: Avoid the impact of hwpoison_filter()
 return value on mce handler
Thread-Topic: [PATCH v3 1/2] hw/poison: Avoid the impact of hwpoison_filter()
 return value on mce handler
Thread-Index: AQHYJKvOle06/UtUpUiUl54AqZS8bKydPF8A
Date:   Mon, 21 Feb 2022 01:32:16 +0000
Message-ID: <20220221013216.GB3968455@hori.linux.bs1.fc.nec.co.jp>
References: <20220218094056.2056251-1-luofei@unicloud.com>
In-Reply-To: <20220218094056.2056251-1-luofei@unicloud.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4c8fa72-0cc0-4edd-b2eb-08d9f4d9fec0
x-ms-traffictypediagnostic: OSBPR01MB3191:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3191D187B8E38C3346286461E73A9@OSBPR01MB3191.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8f5/xIgxL+Wk3560Lwe9KxTrw9aJWHP8F7ENZBdM0NilYDHZFUk/9H0VDWXhcOiJml8twOjjvlR0eY2bwVn8HZg/Q2mEbMU8is3W2vx+rMMs68zAWhvtIS641jRTVJTZYa0bxfXmZK06HIu7srOuyZZEhc3ZcMjJp7GHJnuPgEMmoFzxfFUE+5YPxmndVyvEXOhhrIYuu7e/IuijWvoXJ4iitVSFaUUE2U4atGNYy8S7QNDhb0u62b4FtVgIAoKv3I0MPnpw/BjsqHiyY0/0m5RYV5bNrq/4exhP0ARo8XBL52Lkm9ZJph3ZMB4qE4FLXf5Do79FRwo2es8owOrcl/Aq0pt2tYtQysTVQCsCSfqMkkuvYzw2hivCD4LkKR9IoY/Kab/2n3vT+YiHOaRZvObG9Q0ZW7GYt1PQkEpkfzSdfBKVOZerVIV+5WUSWHFAmCuEvt7wfAN5m658KBsMIcbzWuZ1LUkBWNI+3RMIaymn/o1gEU13PBdRDGDIw3iR6CTUflDN4XbD8m2SkAjBbE/Zjr0WGUnvYIvqxDMATw6zN4o4TBQwneOZgGjQbzFdChRr/BlpaFU47bLOWM/n1lKAcpxgDMp3ciiAxmvVa6wat4LObdqPpscx3u2RlLWXmdGo7ntogDycbGWqWlXG7ZwHXc+ef6doq85lbleZfr4MYbp9O9/o4B5EcAU9mNv9p4j8lV+6r2aH0IqWVtVxGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(38070700005)(38100700002)(83380400001)(7416002)(5660300002)(85182001)(2906002)(8936002)(33656002)(6916009)(54906003)(66476007)(8676002)(64756008)(66446008)(6486002)(6506007)(55236004)(186003)(26005)(66946007)(9686003)(66556008)(76116006)(6512007)(1076003)(122000001)(82960400001)(71200400001)(316002)(508600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjZVOWE1V1FUTlFDbzZ5dkQrLzBLdFNJTlIxdU5uMkl6alc1YXdIckNRTkJD?=
 =?utf-8?B?MlRTMGVzSnlrc1NJY042MnRiTVRHOXZGTnI2UHBobFdQV01oYkptLzcxWVlZ?=
 =?utf-8?B?YXVTOXQ1WmJ0Q09MSExJTFdpWnhkNkxXMzNvVURJT2NRT1R2bWpJaVdSLzU1?=
 =?utf-8?B?MW13TnJBWFkxV3ovVjlQWHZHd1VqU2dlOXc4SWZDeSs0LzhMU3hpaEtFWDFI?=
 =?utf-8?B?RmZ6VmZzVVVNTmNEc2lpOHh4TmdlcllFOHppMUc1REovT3hBSmR4aDJNb2VV?=
 =?utf-8?B?VlBOd2NxTFY5ZHFIQ2pJb3RhM3JuRjVQcCt6c3VIS3hTWW85aElGM29lK0Ja?=
 =?utf-8?B?Yk40b3hTZUN5VWJDRmN0elN3UklScDV3WHdSdVErWXRKM0YyYjY3a29mNDdY?=
 =?utf-8?B?TXhOYkloZWNQZjl6NDNIbEU0UitJSmhRNUVFeGJvamFtTXpKemZHcTB2b0ZC?=
 =?utf-8?B?ZHN2b2s4QlFLVVpMTnZrWWk1YWFjZk9rWGNTTnlIak93MjZlcVZFK2k3eTdT?=
 =?utf-8?B?dEpUUjEydkg2SDBjTmhvZUJ2cEpKY3dhd3cvYkMzQk1VSmJWRXdHeFlyQU1t?=
 =?utf-8?B?SmJDZmZUZTFva0N2bXpvMmg5dmViRGR3OEtmM1V0MEFaRnZuTHZRMTByYjFt?=
 =?utf-8?B?MHJPZlBFcHA1QnhZcXdKR3BXMUF1dTdOVTJYMXB6cjh5Y1Q5bE9rTjhUNktB?=
 =?utf-8?B?Yk03aWtLTm90eGxNR3NJNU5ZYU1ld1NkNFg2dDVLK2plU1o5UkVRQnVPelE3?=
 =?utf-8?B?anR0VlZ2VHU0T1hCRCtsaTdJTHpEQUpFVUNXK0x0L2VSa2ZUSHhxTEQ0eGJp?=
 =?utf-8?B?aWY2dGFuTlpDKy9SdlJkdzhsQzkrZVIzdGlyRU8zc0VqanA4dWcrWW9ZZnJa?=
 =?utf-8?B?ei83RW5SS1ZLRnM4ZDE0SERrVHJlVTZWRkhQTDE5a2dwTHdnOE81YXNzc0di?=
 =?utf-8?B?YStFbkNyQzBnVU9ZSmF6REpMcW55eWJXZm1DOGcyazNsSDZ5aGNhQmtRYmVJ?=
 =?utf-8?B?QVAxbmVFZ3QydGVYeFljMzhZVmdFT01rR0wzSVJDZTRaRThqdmw2WmxGZ0ZB?=
 =?utf-8?B?SFlDM0FGWXBoRVUzWktDbkdkODVobXFvYUh6UTVzMC9xcENDL2taMkx5L0d1?=
 =?utf-8?B?UFlGNlJrMUhNT3hQQTdTeGVqZW56U2RvSktuQVJwS2dKVytiUS8xdlR5MFR2?=
 =?utf-8?B?VGtoNTRiOGJqTEdwditHQnZCRXUzcy8wZE5Pai9UVFJENnVEcVVMUE5oUmtT?=
 =?utf-8?B?MkdjbHRhVHdrdnpmZ2V0d3lTRVgyc1pqVzZESVVIQjVoUzFlczdTemd2bmQw?=
 =?utf-8?B?OUsvTnJZOFduZHZQcFRyT2gvOE5GVUNoT21RenUrNlVJSUVPTmhBOG1uWitn?=
 =?utf-8?B?WnRWR3BRQStPMytZZC9EYlJJOTBnUGpRWXVjV3dqcFJRSG5Wc1J3VHdPOTZa?=
 =?utf-8?B?cER6WGtpOGd2UFdhQ1NXWDNjU2N5bXBiU0ZCQnk2V3BnMldFY1NDMVYyV2ND?=
 =?utf-8?B?RzJmK3lYaks2Y1M1amVUQTB4UThEOXpxZnQ5c0tBVnFyZGpNNU85Z3NJVlpN?=
 =?utf-8?B?ajA1QkdzUjB3dUtwSW9MVXdJNlNLOW04dTdlbDBzOHc3Zko3amRaRjVJbWZk?=
 =?utf-8?B?cGZEaHFoaDZGQkx5Wmk0bmdaVE5MM1kyUnpEd1NoQXg1dWNBcEhoS0gyQ1V3?=
 =?utf-8?B?a09IQzFEdkdhTWVyVWhBa3lKWkR0UzR3aVRNbWtqaVB2dzkrL1dkR1lsOFB1?=
 =?utf-8?B?NEUxODVFWHY0bk5tSzFMeXZMSTY3ZFBwMHphbmNkT2lsQTIxaFNLZVNaTm9G?=
 =?utf-8?B?Q0RiQW0rdEttTDlldmJ0ZXFJNEVzNE1GbDU3RUk4UlpxNU4ybUJKMTNQN2xp?=
 =?utf-8?B?eWdvaW55Ui8xYVBaSFNzSmFnZ1A2a2NDZXlFbDNIYm1EZlNYMWZIbXVIUUU1?=
 =?utf-8?B?bVVobjZKOHBxUjBibWR1eU9GNzlib0tQbnF0YWN3RldrSHJ3bUhzdFFrSDVm?=
 =?utf-8?B?TnZqSHAwaXFzdTdJSVFnRTdwNkpSRDhMMHJGZE9Nc0h0QzFVTmIrdnd2TVVZ?=
 =?utf-8?B?KzJwTE5jYVVRcjJGU2FKTG9qdjJZaXpXcWpVTE1UcXZRVm5PZjJhWU9wbmVl?=
 =?utf-8?B?MzJuS1lIYzRSekowSVpQK0s3SjJwZlF2cFRGc1hPWVN6ZFEzMjRFQTBDb2Ja?=
 =?utf-8?Q?jnN9I/BF8fm5F9o5A5F4Rr9b5oXnAPNIhe+S8BS3OEze?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <085F90369B479741AD2CACD88CAB7ECE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c8fa72-0cc0-4edd-b2eb-08d9f4d9fec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 01:32:16.7820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /h4W0OYbkA5sNNJUONvwt8MnEmvx1MRKSi40bOgFVJFRlTdhXORam7/APFdlDhByoOz20R4lO8bk+sU+TRJnfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Q29udmVudGlvbmFsbHksICJod3BvaXNvbiIgb3IgIkhXUE9JU09OIiAoaW5zdGVhZCBvZiAiaHcv
cG9pc29uIikgaXMgdXNlZCBpbg0KdGhlIHN1YnN5c3RlbSB0YWcgaW4gJFNVQkpFQ1QsIHNvIGNv
dWxkIHlvdSBhbGlnbiBpdCAoZm9yIGdyZXAgZnJpZW5kbGluZXNzKSA/DQoNCiMgSSBzaG91bGQn
dmUgbWVudGlvbmVkIHRoaXMgaW4gcHJldmlvdXMgcmV2aWV3IHJvdW5kLCBzb3JyeS4NCg0KT24g
RnJpLCBGZWIgMTgsIDIwMjIgYXQgMDQ6NDA6NTZBTSAtMDUwMCwgbHVvZmVpIHdyb3RlOg0KPiBX
aGVuIHRoZSBod3BvaXNvbiBwYWdlIG1lZXRzIHRoZSBmaWx0ZXIgY29uZGl0aW9ucywgaXQgc2hv
dWxkDQo+IG5vdCBiZSByZWdhcmRlZCBhcyBzdWNjZXNzZnVsIG1lbW9yeV9mYWlsdXJlKCkgcHJv
Y2Vzc2luZyBmb3INCj4gbWNlIGhhbmRsZXIsIGJ1dCBzaG91bGQgcmV0dXJuIGEgdmFsdWUoLUVI
V1BPSVNPTiksIG90aGVyd2lzZQ0KPiBtY2UgaGFuZGxlciByZWdhcmRzIHRoZSBlcnJvciBwYWdl
IGhhcyBiZWVuIGlkZW50aWZpZWQgYW5kDQo+IGlzb2xhdGVkLCB3aGljaCBtYXkgbGVhZCB0byBj
YWxsaW5nIHNldF9tY2Vfbm9zcGVjKCkgdG8gY2hhbmdlDQo+IHBhZ2UgYXR0cmlidXRlLCBldGMu
DQo+IA0KPiBIZXJlIGEgbmV3IE1GX01DRV9fSEFORExFIGZsYWcgaXMgaW50cm9kdWxjZWQgdG8g
aWRlbnRpZnkgdGhlDQogICAgICAgICAgICAgICAgICAgXl4gICAgICAgICAgICAgICBeXl5eXl5e
Xl5eXg0KICAgICAgICAgICAgICAgICBzaW5nbGUgJ18nID8gICAgICAgaW50cm9kdWNlZA0KDQo+
IGNhbGwgZnJvbSB0aGUgbWNlIGhhbmRsZXIgYW5kIGluc3RydWN0IGh3cG9pc29uX2ZpbHRlcigp
IHRvDQo+IHJldHVybiAtRUhXUE9JU09OLCBvdGhlciByZXR1cm4gMCBmb3IgY29tcGF0aWJpbGl0
eSB3aXRoIHRoZQ0KICAgICAgICAgICAgICAgICAgICAgXl5eXl4NCiAgICAgICAgICAgICAgICAg
ICAgIG90aGVyd2lzZSA/DQoNCj4gaHdwb2lzb24gaW5qZWN0b3IuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBsdW9mZWkgPGx1b2ZlaUB1bmljbG91ZC5jb20+DQoNClRoZSBkaWZmIGxvb2tzIG9rIHRv
IG1lLCBzbyB3aXRoIHVwZGF0ZXMgb24gdGhlIHN1YmplY3QvZGVzY3JpcHRpb24gLi4uDQoNCkFj
a2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KDQpUaGFu
a3MsDQpOYW95YSBIb3JpZ3VjaGkNCg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNl
L2NvcmUuYyB8IDE1ICsrKysrKysrKy0tLS0tLQ0KPiAgaW5jbHVkZS9saW51eC9tbS5oICAgICAg
ICAgICAgIHwgIDEgKw0KPiAgbW0vbWVtb3J5LWZhaWx1cmUuYyAgICAgICAgICAgIHwgMTQgKysr
KysrKysrKysrLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3Jl
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCj4gaW5kZXggNTgxOGI4MzdmZDRk
Li5kZTI5MTY1YzY1YjYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2Nv
cmUuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCj4gQEAgLTYxMiw3
ICs2MTIsNyBAQCBzdGF0aWMgaW50IHVjX2RlY29kZV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJf
YmxvY2sgKm5iLCB1bnNpZ25lZCBsb25nIHZhbCwNCj4gIAkJcmV0dXJuIE5PVElGWV9ET05FOw0K
PiAgDQo+ICAJcGZuID0gbWNlLT5hZGRyID4+IFBBR0VfU0hJRlQ7DQo+IC0JaWYgKCFtZW1vcnlf
ZmFpbHVyZShwZm4sIDApKSB7DQo+ICsJaWYgKCFtZW1vcnlfZmFpbHVyZShwZm4sIE1GX01DRV9I
QU5ETEUpKSB7DQo+ICAJCXNldF9tY2Vfbm9zcGVjKHBmbiwgd2hvbGVfcGFnZShtY2UpKTsNCj4g
IAkJbWNlLT5rZmxhZ3MgfD0gTUNFX0hBTkRMRURfVUM7DQo+ICAJfQ0KPiBAQCAtMTI4Niw3ICsx
Mjg2LDcgQEAgc3RhdGljIHZvaWQga2lsbF9tZV9ub3coc3RydWN0IGNhbGxiYWNrX2hlYWQgKmNo
KQ0KPiAgc3RhdGljIHZvaWQga2lsbF9tZV9tYXliZShzdHJ1Y3QgY2FsbGJhY2tfaGVhZCAqY2Ip
DQo+ICB7DQo+ICAJc3RydWN0IHRhc2tfc3RydWN0ICpwID0gY29udGFpbmVyX29mKGNiLCBzdHJ1
Y3QgdGFza19zdHJ1Y3QsIG1jZV9raWxsX21lKTsNCj4gLQlpbnQgZmxhZ3MgPSBNRl9BQ1RJT05f
UkVRVUlSRUQ7DQo+ICsJaW50IGZsYWdzID0gTUZfQUNUSU9OX1JFUVVJUkVEIHwgTUZfTUNFX0hB
TkRMRTsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+ICAJcC0+bWNlX2NvdW50ID0gMDsNCj4gQEAgLTEz
MDMsOSArMTMwMywxMiBAQCBzdGF0aWMgdm9pZCBraWxsX21lX21heWJlKHN0cnVjdCBjYWxsYmFj
a19oZWFkICpjYikNCj4gIAl9DQo+ICANCj4gIAkvKg0KPiAtCSAqIC1FSFdQT0lTT04gZnJvbSBt
ZW1vcnlfZmFpbHVyZSgpIG1lYW5zIHRoYXQgaXQgYWxyZWFkeSBzZW50IFNJR0JVUw0KPiAtCSAq
IHRvIHRoZSBjdXJyZW50IHByb2Nlc3Mgd2l0aCB0aGUgcHJvcGVyIGVycm9yIGluZm8sIHNvIG5v
IG5lZWQgdG8NCj4gLQkgKiBzZW5kIFNJR0JVUyBoZXJlIGFnYWluLg0KPiArCSAqIC1FSFdQT0lT
T04gZnJvbSBtZW1vcnlfZmFpbHVyZSgpIG1lYW5zIHRoYXQgbWVtb3J5X2ZhaWx1cmUoKSBkaWQN
Cj4gKwkgKiBub3QgaGFuZGxlIHRoZSBlcnJvciBldmVudCBmb3IgdGhlIGZvbGxvd2luZyByZWFz
b246DQo+ICsJICogIC0gU0lHQlVTIGhhcyBhbHJlYWR5IGJlZW4gc2VudCB0byB0aGUgY3VycmVu
dCBwcm9jZXNzIHdpdGggdGhlDQo+ICsJICogICAgcHJvcGVyIGVycm9yIGluZm8sIG9yDQo+ICsJ
ICogIC0gaHdwb2lzb25fZmlsdGVyKCkgZmlsdGVyZWQgdGhlIGV2ZW50LA0KPiArCSAqIHNvIG5v
IG5lZWQgdG8gZGVhbCB3aXRoIGl0IG1vcmUuDQo+ICAJICovDQo+ICAJaWYgKHJldCA9PSAtRUhX
UE9JU09OKQ0KPiAgCQlyZXR1cm47DQo+IEBAIC0xMzIwLDcgKzEzMjMsNyBAQCBzdGF0aWMgdm9p
ZCBraWxsX21lX25ldmVyKHN0cnVjdCBjYWxsYmFja19oZWFkICpjYikNCj4gIA0KPiAgCXAtPm1j
ZV9jb3VudCA9IDA7DQo+ICAJcHJfZXJyKCJLZXJuZWwgYWNjZXNzZWQgcG9pc29uIGluIHVzZXIg
c3BhY2UgYXQgJWxseFxuIiwgcC0+bWNlX2FkZHIpOw0KPiAtCWlmICghbWVtb3J5X2ZhaWx1cmUo
cC0+bWNlX2FkZHIgPj4gUEFHRV9TSElGVCwgMCkpDQo+ICsJaWYgKCFtZW1vcnlfZmFpbHVyZShw
LT5tY2VfYWRkciA+PiBQQUdFX1NISUZULCBNRl9NQ0VfSEFORExFKSkNCj4gIAkJc2V0X21jZV9u
b3NwZWMocC0+bWNlX2FkZHIgPj4gUEFHRV9TSElGVCwgcC0+bWNlX3dob2xlX3BhZ2UpOw0KPiAg
fQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4
L21tLmgNCj4gaW5kZXggMjEzY2M1NjliMTkyLi5mNDcwM2Y5NDhlOWEgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvbW0uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gQEAgLTMx
ODgsNiArMzE4OCw3IEBAIGVudW0gbWZfZmxhZ3Mgew0KPiAgCU1GX01VU1RfS0lMTCA9IDEgPDwg
MiwNCj4gIAlNRl9TT0ZUX09GRkxJTkUgPSAxIDw8IDMsDQo+ICAJTUZfVU5QT0lTT04gPSAxIDw8
IDQsDQo+ICsJTUZfTUNFX0hBTkRMRSA9IDEgPDwgNSwNCj4gIH07DQo+ICBleHRlcm4gaW50IG1l
bW9yeV9mYWlsdXJlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpOw0KPiAgZXh0ZXJuIHZv
aWQgbWVtb3J5X2ZhaWx1cmVfcXVldWUodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncyk7DQo+
IGRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0K
PiBpbmRleCA5N2E5ZWQ4Zjg3YTkuLjU5ZDZkOTM5YTc1MiAxMDA2NDQNCj4gLS0tIGEvbW0vbWVt
b3J5LWZhaWx1cmUuYw0KPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IEBAIC0xNTI2LDcg
KzE1MjYsMTAgQEAgc3RhdGljIGludCBtZW1vcnlfZmFpbHVyZV9odWdldGxiKHVuc2lnbmVkIGxv
bmcgcGZuLCBpbnQgZmxhZ3MpDQo+ICAJCQkJaWYgKFRlc3RDbGVhclBhZ2VIV1BvaXNvbihoZWFk
KSkNCj4gIAkJCQkJbnVtX3BvaXNvbmVkX3BhZ2VzX2RlYygpOw0KPiAgCQkJCXVubG9ja19wYWdl
KGhlYWQpOw0KPiAtCQkJCXJldHVybiAwOw0KPiArCQkJCWlmIChmbGFncyAmIE1GX01DRV9IQU5E
TEUpDQo+ICsJCQkJCXJldHVybiAtRUhXUE9JU09OOw0KPiArCQkJCWVsc2UNCj4gKwkJCQkJcmV0
dXJuIDA7DQo+ICAJCQl9DQo+ICAJCQl1bmxvY2tfcGFnZShoZWFkKTsNCj4gIAkJCXJlcyA9IE1G
X0ZBSUxFRDsNCj4gQEAgLTE2MTMsNyArMTYxNiwxMCBAQCBzdGF0aWMgaW50IG1lbW9yeV9mYWls
dXJlX2Rldl9wYWdlbWFwKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MsDQo+ICAJCWdvdG8g
b3V0Ow0KPiAgDQo+ICAJaWYgKGh3cG9pc29uX2ZpbHRlcihwYWdlKSkgew0KPiAtCQlyYyA9IDA7
DQo+ICsJCWlmIChmbGFncyAmIE1GX01DRV9IQU5ETEUpDQo+ICsJCQlyYyA9IC1FSFdQT0lTT047
DQo+ICsJCWVsc2UNCj4gKwkJCXJjID0gMDsNCj4gIAkJZ290byB1bmxvY2s7DQo+ICAJfQ0KPiAg
DQo+IEBAIC0xODM3LDYgKzE4NDMsMTAgQEAgaW50IG1lbW9yeV9mYWlsdXJlKHVuc2lnbmVkIGxv
bmcgcGZuLCBpbnQgZmxhZ3MpDQo+ICAJCQludW1fcG9pc29uZWRfcGFnZXNfZGVjKCk7DQo+ICAJ
CXVubG9ja19wYWdlKHApOw0KPiAgCQlwdXRfcGFnZShwKTsNCj4gKwkJaWYgKGZsYWdzICYgTUZf
TUNFX0hBTkRMRSkNCj4gKwkJCXJlcyA9IC1FSFdQT0lTT047DQo+ICsJCWVsc2UNCj4gKwkJCXJl
cyA9IDA7DQo+ICAJCWdvdG8gdW5sb2NrX211dGV4Ow0KPiAgCX0NCj4gIA0KPiAtLSANCj4gMi4y
Ny4w
