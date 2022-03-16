Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C334DAC78
	for <lists+linux-edac@lfdr.de>; Wed, 16 Mar 2022 09:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354235AbiCPIcH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Mar 2022 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354229AbiCPIcF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Mar 2022 04:32:05 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2061.outbound.protection.outlook.com [40.107.113.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE0A63BCC;
        Wed, 16 Mar 2022 01:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWgWcvtSxNhL2C2I3qVKB8P2lDpU8tbZekGf7gjKfMJoAVVTTdhBIZsFFcRmUql33U1lBiteJKIHPpxu+8t5f3Q7mfcQf9RaL9N6Lwhe2F2uuhWt3MIVIQDv+MgPri4yK8ZsaFc0Jl/YJ8V0cjfCnmZwu4UdNJDvKbNR9PdELAqu+Ajyq90OokUthxdKIZsgFpJmGdSWa/z+4SQ8d53w1Omh5E6Q/TK4mEESYiM0UNWXBA87vHIh+7QVcISAOUrFnOOqo9tM04xSgWi9lCZdtaEZnpA3nl2LIZGxME5C65zpNo2RGvJzlvIVB6oNamoihYxCrrkG956Yy84fB0X3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgpWFdd9avZWWsXyY8IOD7X/A6DdhnF0NXMifMADUoc=;
 b=b10rAjJ6LXXqQt0be1QoydYNlr6v9qNYN+F9+r9cCsFWCUgB8RjfFg+Ynf8iuuz5sl3umr7HdAhrD45Eg761XhGamjV7YOSCjqMhyBswr9JFvxDr1gOV7x57KfmlWoZ/ZMqnpRa2HpxbLjwrA9DmZ5ZWJDe20qkasSUY2kUMsbKlNhu2QENPT8pof0pXbvvytHlbxyvLZ9NOD0jrkG1kUscyQocjfuYOledvAXnm+dFdSN4Tacq7POYKkKXb6vO7o6AszHiorbLno9/Gx9psWvhtxRHcoBzIH5RoWPw48yP+q2FFbNpC7+FX4nmKYa7ejz6E/dCcYpnVHYeOzYfU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgpWFdd9avZWWsXyY8IOD7X/A6DdhnF0NXMifMADUoc=;
 b=MKCM66yHq9hN0lWCaxVgCrXcCKAqLifGTR4qdUltBabGWeC9UVzMv9c0XYW6IdN3PflzdNUPZHc8PtPh9sJDfiL7vvgqXgDsHADYQJ/4Uh/lr/bPgSMlcOztjcDZ3awxZ1/YEm6X4xWos7c2GZE7TZUw2b9EGuWnjskywo84jKU=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB3786.jpnprd01.prod.outlook.com (2603:1096:404:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 08:30:48 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 08:30:47 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Yang Shi <shy828301@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page
 compound again
Thread-Topic: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page
 compound again
Thread-Index: AQHYNeVlxzESbmOcrEmeH57axmkwkqy/NJIAgAFO+4CAAEMvAIAA6k8AgAADbgA=
Date:   Wed, 16 Mar 2022 08:30:46 +0000
Message-ID: <20220316083046.GB3840907@hori.linux.bs1.fc.nec.co.jp>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
 <20220312074613.4798-2-linmiaohe@huawei.com>
 <91661cd4-e9be-959f-8b6a-da257a00a879@oracle.com>
 <9826152a-8a83-76a8-ded8-47d185aac0a8@huawei.com>
 <CAHbLzkrg=nQGm=sLnYriZJNZ3QznW5_Ktx6x7cWzV+9QJnRE4w@mail.gmail.com>
 <a3a2ee10-95a5-6624-7846-54e21319c444@huawei.com>
In-Reply-To: <a3a2ee10-95a5-6624-7846-54e21319c444@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eef1dc12-ff85-4cc5-25dc-08da07274536
x-ms-traffictypediagnostic: TY2PR01MB3786:EE_
x-microsoft-antispam-prvs: <TY2PR01MB37867D7F4388889C0DBBA4A8E7119@TY2PR01MB3786.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcYD2qeuZbyqgMqXT/lILDpb169HezfdF81gSDpoSMLZebGRI0QCRk0VQ6f7TgPhxS3iKPptjQQwseTiBDd5ZUFy+03BmbTfy1zD/eeEZSCkDKkhNYmDMH6y4Ln5QwW8sfbsueNEkftfaw47kdtemENs9niBS/D6jcrmXWv/bHOkdexJebydNJGH+QabK/Rmfl9g6eUc0FU105c7gF7kkD9EZnxzeyNtnpiaBzz/wLeR99pjbE6JiFGCyDwu2Picq32173HEH8fhKp8wzT/NKGvI+I9kMfwMDY9lCpS97+aGgE4ZcvZcg+ywnQstUWTAQ1Pqdn7gLSd6342lJgRtb3RAp2kdnxwfq2VzvACh0U+5UlrGeS1GkWAhDy5FGeD0I+ucC2N41EH/QN7AmQWVGaE4Q25qu6olbA2UTdGv6pn4nX4rY/jn6SEIhd79OSStqqaw8EC75uzmKE/zDUTMFXCC3RzjPRIERx19vmSdFBuQS1TWAB3K19AsYC5mNnwdHj3HBIDWBSl8pXURzMUPA7Ct069aMJTn3xOqR3V2SDwA4PcEdW+kR8LZbaIT2LColEGzkLriMoJNVOG20ae+ApAqFG7e85FIAu157dgYZfyOv20ro3Cr7MLN/syKyDp5sIDqQder8vcORlvTbqJe46Dt9eEGJq8uIXgzCseSoBX/CwM/38n77KXqQNcpAkrgKJMRjovcY8xIiW/uzYmq1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(54906003)(82960400001)(316002)(33656002)(76116006)(85182001)(38070700005)(508600001)(66946007)(71200400001)(4744005)(66476007)(6486002)(8936002)(5660300002)(2906002)(53546011)(122000001)(38100700002)(66446008)(64756008)(4326008)(8676002)(66556008)(86362001)(9686003)(6506007)(26005)(6512007)(1076003)(83380400001)(186003)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlJqd2ZXSVE0RGxyRndJVzREbUFjR3JBSmVrRnV2TWdFblE5RGUzTE4yakll?=
 =?utf-8?B?bHZnSXA1SnRWbFU5ZERIejl5QXVQSlkvUzlUaVR3YnZBT3FkaGxuMTdXdksx?=
 =?utf-8?B?NVRvbklSTmpidFBvNldGVzl2SDhFZmVENFJVNGkwUU5LNzNBazB4eEhYcDFE?=
 =?utf-8?B?cHVpa0F4MTBIWkNsekw5YzJLRVY3eE1CdGRzTjg0bjU1dHJWTjIvVUZQOU1z?=
 =?utf-8?B?OHlEdnZMOEJpQzNHbmJIRzhCbUlTSTE0OHdmN1oxTHF3V3UrQXVhRkQ3M1Yr?=
 =?utf-8?B?QzBQdVVGM1o1cmtZb3BiUThSeXpuYzQwR0ZFcFB1NWRmaVFtN0plRFh0QVBi?=
 =?utf-8?B?NS9IZ0lsKzNaYno2Z0ZCWk1seUhrRXJXMkJ1MzdReEdsMXRsdndySVp4RWJW?=
 =?utf-8?B?ZFNFeEJrY2ZLTVA3N3FEdlpmM3FoQm1taSszY2FMUzEzMGVZbDJVbjdxeFV5?=
 =?utf-8?B?dTJRUUZoMWdmcE4wSzFSdklObG5LTU9pSkJaVXNDc3FjbFZMSHJPb1NnbXpi?=
 =?utf-8?B?S3pHVVlmUkJXVkZxK1FMQ3NOUitvTEQvUGc0Z0FEVmt4SVRadGdHUzZjZ2Fn?=
 =?utf-8?B?dkwyRkJQalpxZUlicjBUdWo2VDZwbTZHU0JCUUVvWE13aVVpaEprTFBOdXZF?=
 =?utf-8?B?c1AzNnBwZVZHVHNoMlBDbXowMXdabHdWN2x2bktvYWEyMlpFVkczdjc1N0I0?=
 =?utf-8?B?eW9yZU5yRHhsUHlSTzZJd3Zxa1FDMmtGWjFMMEF5SnR2QzFqVnpSNHpLcXBu?=
 =?utf-8?B?NEYzSHI1Z3Nma2Z5Q2o0b20wcEhBTHh2L2JHbWN0MklPaTdLSlJlY3V4S21I?=
 =?utf-8?B?Y2Z0R0JLRXdxaVZPc2Ezd3VkOVI0TFhlcjJCRGJqNmswbHI1QmJMYW1wSlVo?=
 =?utf-8?B?bldsQmI5RWNHb2J2dVBiUnBOVVE3RSs4ZWRBdFZEa1pQY1Z5MWN2MkJ2ZmxY?=
 =?utf-8?B?Z0J3ODA0UGt4N0d1cDFLOWh4V3RnM0F2WFh1QnhFVVl0OUhZZUVuWmd5YzFE?=
 =?utf-8?B?Nno2UFN3R3NadnZGK1pGWkZTeWd0UTR5WGdyOThFQk0zbUlTUlQxY1dHMWpZ?=
 =?utf-8?B?TVpWa1R6TTEvTXhZTjhnYW9laUxrTkMxdWFzRllBV0NpVGJBTW1vQ0dpM3c2?=
 =?utf-8?B?K3ZCZS9Odzl0QS82aVlRekt1OTJ0OXRnWDJtcVA3ckhRL3VYSGM0NW54MHlD?=
 =?utf-8?B?ZEIyK2xMS044Zzh1ZFdmaDRmWkk1eFFGb3FVZW9mc09HZ0JSOFVoVlZ5WHVQ?=
 =?utf-8?B?SG1lcmRnNU1LbmhoU2V2RXR0dTVTWHdYbEhBUDBOR3NJN09pNzBxZm9maU1x?=
 =?utf-8?B?cERDV1Fab2g4QnlRT0gwRERSbWRVajdlM3o4aGRpT2Vxd1EvK1JWLzBDWWtX?=
 =?utf-8?B?dnBzRHMva3VwcHo2SGV2R1VsWWVTaW5QUUdjSUFoRXBRRlZWZDc5UFZua1pG?=
 =?utf-8?B?VDJBMXJIU1lPMm93YXRNL25KWkNCTStpKzk0eERySTg4RHdPZGVEeVhSYk5u?=
 =?utf-8?B?L0hxcWdiRjFicFY1b0NFckF3L2k5cEFnU2x0TElxc0htaGNyR0tvaUpucisx?=
 =?utf-8?B?MDhOWXhlL3ZSTGhSeXI2dkVQa2d0QWFJam01dTN1eDgzVXA0Skxpc251Tndy?=
 =?utf-8?B?b2x1eEVsMEFFcGQ0TlhmU1AyWHRmSFNlMjdFMmZNbHlPcU1TbExLTDRndUJO?=
 =?utf-8?B?WERXNjgvbUpYNDlqTHQ2WEdGcWlqKzlpTnprdWtnMzY3SkRRWFVOd2xLZWZ4?=
 =?utf-8?B?VmpKQzdDTjNVaGdMc0RWbGdsdHZ4MTNaMmg3aGcvaUxyWGFieEJFbzdsT3Nl?=
 =?utf-8?B?bDM2ZERBZkREUlBRNW5xdVhkVCsvRDlTRzliU2ZNek1LQlZYbzgxcGhyYTJh?=
 =?utf-8?B?Vm1ERVdwSCthMlptTTMvcGZsYnU3cjRJVmJJQnVwc2FEV28xQ25IZFZ4RDdx?=
 =?utf-8?B?QWZuOW1SWXVtV0xzK1lQRVhlYklra2ZyWm5od1pwdTdPMXVGODdGUDZHMTYv?=
 =?utf-8?B?V2pDVmpab2d3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47B072C6AB79A648944D79A605152E0D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef1dc12-ff85-4cc5-25dc-08da07274536
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 08:30:46.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /w2DaPJ/2+YJMu7lPXkpVJiOP0DPVqWsH40o63gA+6AOSukPardH6dhmHka2uY8jv6nvP/0SebpevfyGCUU8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gV2VkLCBNYXIgMTYsIDIwMjIgYXQgMDQ6MTg6MzBQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi8zLzE2IDI6MTksIFlhbmcgU2hpIHdyb3RlOg0KPiA+IE9uIFR1ZSwgTWFy
IDE1LCAyMDIyIGF0IDc6MTkgQU0gTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+IHdy
b3RlOg0KLi4uDQo+ID4+DQo+ID4+DQo+ID4+IE1hbnkgdGhhbmtzIGZvciBjb21tZW50Lg0KPiA+
PiBJIGFzc3VtZSB0aGF0IE5hb3lhJ3MgcGF0Y2ggIm1tL2h3cG9pc29uOiBzZXQgUGFnZUhXUG9p
c29uIGFmdGVyIHRha2luZyBwYWdlIGxvY2sNCj4gPj4gaW4gbWVtb3J5X2ZhaWx1cmVfaHVnZXRs
YigpIiB3b3VsZCBzZXQgdGhlIFBhZ2VIV1BvaXNvbiBhZnRlciB0aGUgYWJvdmUgY2hlY2suDQo+
ID4+IFNvIEkgdGhpbmsgdGhlIGJlbG93IG9wZXJhdGlvbiBpcyBub3QgbmVlZGVkIGFzIFBhZ2VI
V1BvaXNvbiBpcyBub3Qgc2V0IHlldC4NCj4gPj4gRG9lcyB0aGlzIG1ha2VzIHNlbnNlIGZvciB5
b3U/DQo+ID4gDQo+ID4gSSdtIHdvbmRlcmluZyBpZiBpdCBtaWdodCBiZSBiZXR0ZXIgYW5kIGhl
bHBmdWwgZm9yIHJldmlldyB0byBzcXVhc2gNCj4gPiB0aGlzIHBhdGNoIHdpdGggTmFveWEncyBw
YXRjaCB0b2dldGhlcj8gSXQgc2VlbXMgd2UgYWx3YXlzIG1pc3NlZCB0aGUNCj4gPiBvdGhlciBw
YXJ0IHdoZW4gcmV2aWV3aW5nIHRoZSBwYXRjaGVzLg0KPiA+IA0KPiANCj4gU291bmRzIGxpa2Ug
YSBnb29kIGlkZWEuIFRoaXMgd291bGQgbWFrZSB0aGUgcmV2aWV3ZXIncyBsaWZlIGVhc2llci4g
SSdtIGZpbmUgaWYNCj4gdGhpcyBwYXRjaCBpcyBzcXVhc2hlZCBpbnRvIE5hb3lhJ3MgcGF0Y2gg
YWx0b2dldGhlci4gQnV0IHdlIG1pZ2h0IGhhdmUgdG8gY29uc3VsdA0KPiB0aGUgb3BpbmlvbiBm
cm9tIE5hb3lhLg0KDQpJJ20gZmluZSB3aXRoIHRoZSBzcXVhc2hpbmcsIHNvIEknbGwgc2VuZCB2
NC4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
