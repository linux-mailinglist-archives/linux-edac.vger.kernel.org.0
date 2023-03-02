Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5066A7AC6
	for <lists+linux-edac@lfdr.de>; Thu,  2 Mar 2023 06:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjCBFYZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Mar 2023 00:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCBFYY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Mar 2023 00:24:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13E642BFC;
        Wed,  1 Mar 2023 21:24:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j84RTGhsLJ++RIEWQAkcsOvO6ms/3bot2YBUcRLhGX16+OGsZd4pOzXSurwkqFE9BsShM6ivCeQkXaca4vQYu/CdMYopFvxV1Q9azyzbz/+kxR7ajQkDU4hfMlaoLeTy/fyUVsNg7C9teKKdtcMFSiVSI55fiQmVNUZ5gvGSwCQH6sbmgzf/rxQvGxfwbtaPp3ddm0qZFSkzHLHdCB6FexWmqR4G7o2f6GIeOnvs0JdC5yn3Fs9VxIAWviwSotdELu+KSwoaiN7sxAXsjICsbY6+k2jIdgOnWEe02YWxzPgLi1nv38HMb9qUXSJm+HBtSPdHlkBF7KXhxjIl2u1/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s0M8GCuBnOGdTIXlpdLukJwrVIFg80wiFGL2DXCFx8=;
 b=iKki8NC9Acwed80Vo/ICt4SqO6IeRlfCYSQnD2jHivhn+PvN5Q3MuwyHocUuikG7OsPp0HGcVea+9BCN5RpIFwl+konwFaP55ZN6DOIaZliqexXLeVO/aZ9kKRkCiOYAc3J1BLE0cHQdhnwaEmNpA7aDSoYS8piPWnXXSU+XxfBhBavEE/xxHfMobal2AYv9vrNZjyCyyfzJflkYjGEhyXvIEPaLAnMfn0yFGA+uL2P3Wzi1+2DEdvQ/M+17XFaGVuVN4ce/dEn52enQCHtKs8lVkd3fHzhE6i78MSDBkGwOxtpCCTpbS4rhn/y5r7eEiINnj5QwxFu9+DP+TQLIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s0M8GCuBnOGdTIXlpdLukJwrVIFg80wiFGL2DXCFx8=;
 b=0jPMqGf5gcF9pmpQzc7fGnJ6vAkL0LiRx9Jtr62EZwfz5u2ODt5BrTBL6pTxJ2hbh4VkGjKCkzgKKqFfy7H7xnTbv9TSUhQemzBO1OvYubM8qDfnhvPHEVOllMYDdKTczcrfc/e5sB61/BHXV448qvqthtXrTBxlAiy60nnswo8=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 05:24:16 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::8dc2:6f02:faaa:deb]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::8dc2:6f02:faaa:deb%9]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 05:24:16 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: RE: [PATCH v3 2/2] edac: xilinx: Added EDAC support for Xilinx DDR
 controller
Thread-Topic: [PATCH v3 2/2] edac: xilinx: Added EDAC support for Xilinx DDR
 controller
Thread-Index: AQHZKjZVo3gEKD/o00q39C28xpAK3662CLEAgDEurbA=
Date:   Thu, 2 Mar 2023 05:24:16 +0000
Message-ID: <BY5PR12MB490209C639C9ADD9FB67F75D81B29@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20230117054100.8377-1-shubhrajyoti.datta@amd.com>
 <20230117054100.8377-3-shubhrajyoti.datta@amd.com> <Y9bu8CpiVKvFS1d+@zn.tnic>
In-Reply-To: <Y9bu8CpiVKvFS1d+@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-02T05:24:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=56cea35f-661e-4358-9918-726ab0f14aa2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|CY8PR12MB7514:EE_
x-ms-office365-filtering-correlation-id: 4dbe2aa7-d7b3-4a2f-e075-08db1ade5dbd
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OfheAN4ezshIsXtjuueWt1yp//Fw2TmtGwjUfx726JDP3rDUQR3LZDX6tmy0ATor+E743WpOfkxdohhcOuT+eqdRnpyh7WPmB5LiG9HAU3GJWM7KWUGQXGV9YodGvbry7L9rL0CkJdAv/3SYVA4BG/wQW+zixUGEdiUnyvlzbkUp6ANJmX+F8ZJy7gghYy71tDE8rVxIVhXEpyUkcPBtvpdtR4GApm9x47jh3CCt5JfZeEcSK7rO4RNQMWrg7u+iEXcnl6C17fLzoW5Wyxguut6kggfh3BJx55B3OumTMaoUqVHKCyILyZ7A0dThC/x8Zhqcp+NuswHTqHV4ABXazvqYX6s8wInYtGifeHb5y7sIYw9fESSUE368nvlQegi/MFF7UV04vjopxfdOmEVd+IQfV/dL73XsctUh3+KEpxT3fIfbs6k4SKZ7jE+7OVvK7x/1Da+/2mnz9bHGcQP1DLr85yqyp8ltrKQ3nUpAgSulccz5g66IMPIu761NGO+nUEdClcrMzRjf+74sKHrLdV7C721IvXsmWg2auYi1Opd5U8QVVpCR5droQ9D86sjqq1YZXtI5u5AijCcr+WiKJINYLVlAQo7aDYydhz+b2NVviz/AjoIE2IZqt2myQKWA7PvR2bPDZVvtTyoJhwK8mDSWFfcMpk4XXDslq5T7DapMWvbyNkz1R5D0NGZsZayzfGgJQQEw7wEANiOFrXoeaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(41300700001)(8936002)(54906003)(52536014)(9686003)(55016003)(6916009)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(53546011)(76116006)(33656002)(86362001)(186003)(2906002)(83380400001)(6506007)(26005)(122000001)(5660300002)(316002)(478600001)(71200400001)(7696005)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXpyTWpiRXNNQ0VLMVR6amRiZGYvc0dORU9JSm0zVmg5RFFaUjlPSGZ6VjFV?=
 =?utf-8?B?dURBNUJWZXYxaldUb0psMmphb1ZQY1ZsV1p1MmxzYWJsQncycDh1TlZtdVZK?=
 =?utf-8?B?WXZoVmw1QVJaVC9haUU4WGhZRjhQVmtkejNiVVk4eFZ6Q1kxd09vcEF3MDZF?=
 =?utf-8?B?M0lHc29uUHpGZjIvNHRUaGFDK2h6K3owRnlMc29LNEw4WktkS1UrYWJyWCtL?=
 =?utf-8?B?Y3E1clNic0lPdUd1Ky9EL1ZDK0trT2FlOEFRSlNla0J4MWxncVE5MWc0dTZq?=
 =?utf-8?B?Wm01TTZMN0tkZk1WbTNnTzlZUitFUGR2NTEySUJwYWwyV2t1WDYyK3QvYWlT?=
 =?utf-8?B?cWxjRVVTdGFDaUpDRXpIZjB4TEhaQkJKN1ZMODBvbUMvNzZ2Ky9YQTFDVGVM?=
 =?utf-8?B?Nm9GY25reldKY25NUTN4ZW1VUkd6ZHBTSVZ3OGVTZ2c2dUZGOHdIWEdxbGx5?=
 =?utf-8?B?MVgxeU1qZTZPREN4UE02T3JBK2NaQi92RStpUFBNZlJPNGFhYTg2bGxkeGtG?=
 =?utf-8?B?UzBlNVZOU2txQ29qMXJVNk9mWEJ6NWR1OWttTXllY0tQNFlYT2h6bjI4REhi?=
 =?utf-8?B?UGpmYzZBTXlpeDR6Z0FMM0d6UmdkRTVMUGxmU1EwdjkxNHZQQVFMTG1mcTdJ?=
 =?utf-8?B?TElBMndiY1gxR2FkeTZ4WDNwM01MMUNFQmdnRDAxdm9RREM5emo2cjVWM2I3?=
 =?utf-8?B?azFzWXFLeHVubXU1c0pEVTNSSDhXR2MzZlloWksrMjdCaXRBRUpiaHg4a3NT?=
 =?utf-8?B?Q1RUTGZhamtsTTE0bDdhT3VtTFdMRkI0L0x6cFU5UDdEUGZWcE0rN3NBL0ZW?=
 =?utf-8?B?a1VlRHFDYmx4QkxPbzkzQzJMMytZa1BmT0syMjRGYTRJT3UxSzcwTGg1c1U4?=
 =?utf-8?B?bWxVcEU3RnJvWVlCN0lhL2JyTkMzZWJFSXpOS0ViaTMzRDJibER2OElmNEV4?=
 =?utf-8?B?MjNOSVhadFQ2V1NFeE5IakZzS1lXWFQ4ZG1mYWtGRVY3Y0xjajRuSi9uSVFW?=
 =?utf-8?B?MlMzVW0yVitMQzRxbG1FMlBEY3VqbEwzSGRqbzVpa1JvcmdVbm0vT3VqYWZk?=
 =?utf-8?B?MHhXZERNVDlrSlhCK1J5STFQYjdrM3U2V2tQNEU4ZGhIV2NFSi9lQU5tMyts?=
 =?utf-8?B?Vm16LzVjWGc0TndiNWZtbGVoVk4vNUdyUmVZa1NsdThlVWRUN3gwVjdhNlRY?=
 =?utf-8?B?WDVqZUVtSkNHZ3QydGt0NkN5UWRubndDbmN0K3RWQ0JsdnI2c1lna1hURmQ5?=
 =?utf-8?B?cERqdHM5bVdwQi9mdjJramxDL3JRLzF3VzJrajFNc2FRK2JrZG5JUlJTQ0tF?=
 =?utf-8?B?RlV4Q3ZhaG1FMkV6cVBaRmRhU2QvRTRjY1M5ZlNweG9PVmt6WmxFajJiNWtO?=
 =?utf-8?B?bW9wVFNoZ21CeGFJeVIrSE5NMTJmekd3ZEpFZ2ZxTU9qY3FjcVFZdG9IRXZv?=
 =?utf-8?B?Ukk5d1M0ZWNTYXdLaTNNVzA1QStJWkh6cG1zNXFqTjZPeWk5N1JCR0oyaGlB?=
 =?utf-8?B?YTVuT0k1eGhYaGhVcTlkb0pzd2ZlMjl2Y2NuZlpsWGdvamovRGFVL1BmQkdy?=
 =?utf-8?B?bk50R3d0amQ0Z3E3N04rYXdGQW5LejlNTWNqWDhZWVl3bWlDc2RpaHp4c05p?=
 =?utf-8?B?NEFndlk0bFJwb0VpYXdOUE5TOU1zVFFaQUZjSFdYZmhsMW1tTXZTcWFoOSsv?=
 =?utf-8?B?VU5SdXF6a3AzQXNoT0RoZHIwV2VOT1BkL255SzR3aTZsYUN3YWhxTmNEVENL?=
 =?utf-8?B?Rnd5WFl5ZTNBS29ML2wvc1FaZXJBNUtwUHhoY3o0Tm1wbUlieWd2K3ZoZHhl?=
 =?utf-8?B?Qnp2YjlYK3VLODIxZXFZejhwQkVicjhyRmNWMjk1U3o1eEV0akF4ck8zMFQ2?=
 =?utf-8?B?djQxYWdpbEw4ZUx0cWk4YWlhSTNRcHpBUG5mYlR4anBVL0s1VWJVWjdtSXNR?=
 =?utf-8?B?ZTBkbmw2Nk84TEZmeDJyNzg1TEJ3KzZJVkh4ME85bHU3ZWpFU0NvSWZ0b0VG?=
 =?utf-8?B?YWhacDZGYWMxTnkrc3dYSEFnRldnRC9WcFVxdHJ6Lzg1ZTAwVzVpeWFmVFFD?=
 =?utf-8?B?TnVDbW9TREJVc09kaXlFTUFRdk5sL1hGOVJqQzJpZDF2OEtuTE5hU1QvWTk3?=
 =?utf-8?Q?iDJw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbe2aa7-d7b3-4a2f-e075-08db1ade5dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 05:24:16.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7QDeP2BiEAEI0rejsz5tlnuvRdYo6/oUt66stkAkmqtjzuk/IZ1X8xXH7UK4wYhMXx+LjxLiPBqMJAP8jmOvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhJIEJvcmlzLA0KDQpUaGFua3Mg
Zm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Qm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAz
MCwgMjAyMyAzOjQxIEFNDQo+IFRvOiBEYXR0YSwgU2h1YmhyYWp5b3RpIDxzaHViaHJhanlvdGku
ZGF0dGFAYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBnaXQgKEFN
RC1YaWxpbngpIDxnaXRAYW1kLmNvbT47DQo+IG1pY2hhbC5zaW1la0B4aWxpbnguY29tOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3Jn
OyByb2JoK2R0QGtlcm5lbC5vcmc7IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gdG9ueS5sdWNrQGlu
dGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gZWRhYzogeGlsaW54OiBBZGRl
ZCBFREFDIHN1cHBvcnQgZm9yIFhpbGlueCBERFINCj4gY29udHJvbGxlcg0KPiANCjxzbmlwPg0K
DQo+ID4gKw0KPiA+ICsjZGVmaW5lIFBDU1JfVU5MT0NLX1ZBTCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4RjlFOEQ3QzYNCj4gPiArI2RlZmluZSBYRERSX0VSUl9UWVBFX0NFICAgICAg
ICAgICAgICAgICAgICAgMA0KPiA+ICsjZGVmaW5lIFhERFJfRVJSX1RZUEVfVUUgICAgICAgICAg
ICAgICAgICAgICAxDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFhJTElOWF9EUkFNX1NJWkVfNEcgICAg
ICAgICAgICAgICAgICAwDQo+ID4gKyNkZWZpbmUgWElMSU5YX0RSQU1fU0laRV82RyAgICAgICAg
ICAgICAgICAgIDENCj4gPiArI2RlZmluZSBYSUxJTlhfRFJBTV9TSVpFXzhHICAgICAgICAgICAg
ICAgICAgMg0KPiA+ICsjZGVmaW5lIFhJTElOWF9EUkFNX1NJWkVfMTJHICAgICAgICAgICAgICAg
ICAzDQo+ID4gKyNkZWZpbmUgWElMSU5YX0RSQU1fU0laRV8xNkcgICAgICAgICAgICAgICAgIDQN
Cj4gPiArI2RlZmluZSBYSUxJTlhfRFJBTV9TSVpFXzMyRyAgICAgICAgICAgICAgICAgNQ0KPiAN
Cj4gT2ggd293LCB0aGF0J3MgYSAqbG90KiBvZiBkZWZpbmVzIQ0KPiANCj4gSG93IGFib3V0IHVu
aWZ5aW5nIHRoZW0/DQo+IA0KPiBBbGwgdGhvc2UgcmFuayBtYXNrcyBsb29rIHRoZSBzYW1lLg0K
SSBkaWQgbm90IHVuZGVyc3RhbmQgdGhlIGNvbW1lbnQuIENvdWxkIHlvdSBwbGVhc2UgY2xhcmlm
eS4NClRoZSBzaXplIGRpZmZlcmVuY2UgaXMgbm90IHVuaWZvcm0gc28gYSBvZmZzZXQganVtcCBz
dHJhdGVneSBtYXkgbm90IHdvcmsuDQoNCjxzbmlwPg0KPiA+ICsgICAgIHVsb25nIGVycl9hZGRy
ID0gMDsNCj4gPiArICAgICB1MzIgaW5kZXg7DQo+ID4gKw0KPiA+ICsgICAgIGZvciAoaW5kZXgg
PSAwOyBpbmRleCA8IFhERFJfTUFYX1JPV19DTlQ7IGluZGV4KyspIHsNCj4gPiArICAgICAgICAg
ICAgIGVycl9hZGRyIHw9IChwaW5mLnJvdyAmIEJJVCgwKSkgPDwgcHJpdi0+cm93X2JpdFtpbmRl
eF07DQo+ID4gKyAgICAgICAgICAgICBwaW5mLnJvdyA+Pj0gMTsNCj4gPiArICAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgIGZvciAoaW5kZXggPSAwOyBpbmRleCA8IFhERFJfTUFYX0NPTF9DTlQ7IGlu
ZGV4KyspIHsNCj4gPiArICAgICAgICAgICAgIGVycl9hZGRyIHw9IChwaW5mLmNvbCAmIEJJVCgw
KSkgPDwgcHJpdi0+Y29sX2JpdFtpbmRleF07DQo+ID4gKyAgICAgICAgICAgICBwaW5mLmNvbCA+
Pj0gMTsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIGZvciAoaW5kZXggPSAwOyBpbmRl
eCA8IFhERFJfTUFYX0JBTktfQ05UOyBpbmRleCsrKSB7DQo+ID4gKyAgICAgICAgICAgICBlcnJf
YWRkciB8PSAocGluZi5iYW5rICYgQklUKDApKSA8PCBwcml2LT5iYW5rX2JpdFtpbmRleF07DQo+
ID4gKyAgICAgICAgICAgICBwaW5mLmJhbmsgPj49IDE7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4g
PiArICAgICBmb3IgKGluZGV4ID0gMDsgaW5kZXggPCBYRERSX01BWF9HUlBfQ05UOyBpbmRleCsr
KSB7DQo+ID4gKyAgICAgICAgICAgICBlcnJfYWRkciB8PSAocGluZi5ncm91cCAmIEJJVCgwKSkg
PDwgcHJpdi0+Z3JwX2JpdFtpbmRleF07DQo+ID4gKyAgICAgICAgICAgICBwaW5mLmdyb3VwID4+
PSAxOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgZm9yIChpbmRleCA9IDA7IGluZGV4
IDwgWEREUl9NQVhfUkFOS19DTlQ7IGluZGV4KyspIHsNCj4gPiArICAgICAgICAgICAgIGVycl9h
ZGRyIHw9IChwaW5mLnJhbmsgJiBCSVQoMCkpIDw8IHByaXYtPnJhbmtfYml0W2luZGV4XTsNCj4g
PiArICAgICAgICAgICAgIHBpbmYucmFuayA+Pj0gMTsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+
ICsgICAgIGZvciAoaW5kZXggPSAwOyBpbmRleCA8IFhERFJfTUFYX0xSQU5LX0NOVDsgaW5kZXgr
Kykgew0KPiA+ICsgICAgICAgICAgICAgZXJyX2FkZHIgfD0gKHBpbmYubHJhbmsgJiBCSVQoMCkp
IDw8IHByaXYtPmxyYW5rX2JpdFtpbmRleF07DQo+ID4gKyAgICAgICAgICAgICBwaW5mLmxyYW5r
ID4+PSAxOw0KPiA+ICsgICAgIH0NCj4gDQo+IE9oIHdvdywgNiBsb29wcyENCj4gDQo+IEknbSB3
b25kZXJpbmcgaWYgeW91IGNvdWxkICJ1bnJvbGwiIHRob3NlIGxvb3BzIGFuZCB3b3JrIG9uIGVh
Y2ggY29tcG9uZW50DQo+IHdpdGggYSBzaW5nbGUgbWFzayBhbmQgc3VjaC4uLg0KDQpJIGRpZCBu
b3QgdW5kZXJzdGFuZCB0aGlzIG9uZSAuIFRoZSBsb29wIGFyZSBydW5uaW5nIGZvciBkaWZmZXJl
bnQgaW5kaXhlcy4NCj4gDQo+ID4gKw0KDQo=
