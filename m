Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4450C7E1
	for <lists+linux-edac@lfdr.de>; Sat, 23 Apr 2022 09:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiDWHGp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 23 Apr 2022 03:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiDWHGp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 23 Apr 2022 03:06:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B126212C;
        Sat, 23 Apr 2022 00:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqFTu7PA+syB3IKMN7EGqXp3D9UVlqGvhx/O2Lkh0SjOZQdOrj6GdifwSVIXKtQAJRL7mp3qf6u46e31h1+Tx25RVSG3WEPUt//GCIALAq9VL6eRGdKcKX29B5XLOi1FjxKNcBa+kLNpS+Hqj1zl5B5mBBF6CnLe9zNow5wdc2ywmlhBibPRu5row3q7a9tlDtszeIzoBmmah+5wrmxTWQwRAxSXZzGegtEfxVJKIeqergxZMnujj+Bq9eXZZ27bovDb0dKtyWnn8npyzTdq0HslT3amsU+fIwVqiXodkZD4TitIfjYda7ypzsJS49tDwE1WEI6JvFZyjT2LywFkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhBkChADNXn8KvSy4ZB1YCAHA4wApxYU8TDugJTNlQw=;
 b=Ry5M3HyPd61YwnDXYALj5vdBCUQdqOTNGiEUIBWp+yNlfqeluxJabMrXlU9tVf/QRXX7yoUnCpFD0unltkAIvpGrJ+HraD+ZaK/GVDOLnJqeCXJ7j+yYP49ETCD2LgDkaoXBQUohVw82DrS1gXOwG3fsmYbUFhz+zgnh5TsKv62WriU/f1ktaGrSNIxIM01QeHVQw8C3/VmDWswbb2Pru/un9dlVaoFpNMlZHOpyO0gjz05BZjR/XyXPkSfSlRxIGz0J2xxHkOios4zy2xBu6BKI8LmkT/e8amG4wCuzhY7P/eJa3QmN007lwJmo2m0cMNNv0xW6PqpFrt0YIwNFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhBkChADNXn8KvSy4ZB1YCAHA4wApxYU8TDugJTNlQw=;
 b=KmF0iyIN7DcjXBDdYZS+RJRfClRda03zLvi+K9p7XJA2n/UCinzM53wdCWED+xB/jDn/TTzHFH/XRU9c3cb4/8klVOg0giDlAIsmbsIVbrWL1+u9TJ/aDIj78+VOWf8qI5mNdrNH6w2Waho2+7DCbBQ573RLKFNrRUgw+lmiOOk=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM5PR0401MB2609.eurprd04.prod.outlook.com (2603:10a6:203:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sat, 23 Apr
 2022 07:03:45 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6%5]) with mapi id 15.20.5186.018; Sat, 23 Apr 2022
 07:03:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Shubhrajyoti.datta@xilinx.com" <Shubhrajyoti.datta@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/2] EDAC: synopsys: re-enable the interrupts in
 intr_handler for V3.X Synopsys EDAC DDR
Thread-Topic: [PATCH V2 2/2] EDAC: synopsys: re-enable the interrupts in
 intr_handler for V3.X Synopsys EDAC DDR
Thread-Index: AQHYVSMQdKtwPj34AUOq3rkHbkAYhqz6FAQAgAL8+3A=
Date:   Sat, 23 Apr 2022 07:03:45 +0000
Message-ID: <AS8PR04MB8404243437B78FA6B1E46F3092F69@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220421015313.5747-1-sherry.sun@nxp.com>
 <20220421015313.5747-3-sherry.sun@nxp.com> <YmEerhSXM0L8cUuj@zn.tnic>
In-Reply-To: <YmEerhSXM0L8cUuj@zn.tnic>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c95ea027-ec35-43fb-eff9-08da24f76881
x-ms-traffictypediagnostic: AM5PR0401MB2609:EE_
x-microsoft-antispam-prvs: <AM5PR0401MB260963AE5B9A37CB02E9D32092F69@AM5PR0401MB2609.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qC05vmDefZK3nY+rFCmB2v8frS1qhdGDO1eExuV4ZAAwdgvYVy1HavsdcgC4KhZ5WsZvELf6SsanVqmRAUyTtr6fLd61PSVKLggzsCj3yN/IwCW4gSq08oagB64rMmw0+NLSd0Zwkj+wuLCyaiEgjOFnTpV6HijGkgL8Yl62rAhaaMP/KCHKP2C2u8QwOSjPBAlRkAUdbzdcpl4iu0C1mll8ktm8pODR/cuV9TMxUpLDi6Xr55QHPbANGrhjtfYDXsp3yUeMC4KbTxEEuHecmVqSshoZawEgehB2JHf5wUyxVaR0426Ae+rglLKUJEaR/LfSa4GNqC80UEUIDgmZfbBBZXTYqQSiBN+BCCjAgsDNzoNtl/DfhyNVFY0mwgrlj6RA5L/VFtHns8ePWTJWvx0HmgwvH7+tuEpHFp4rTyIDpfbmxbId/pN1m1p+LdvDIaYhLB9Wh9aWA6EyNuzZKj56zIEQQ5lklZA4d2ceQRcTspB6VN58Tq0wHL4NzvitGQYTdAR5RrjZjr38Fqt/T5uq2OKqdXrRrL8YAHv3VjjWEyjK0Xwb+dQ+R4o/bSqmJXY5LYPdbKThEn+z0A2W5KG4BpwCk19KWQ0Jaw/n3vqZf603IFN1+kQ7UhkkjQTlLR7abs5qeNmk0nl5Ey14COzevLu2RC/F8+e/igPT3Jz7VA+D3c0lNVBPl5iB3HLiE5c1dlkKQZr7VyAf+tqYLtiOXb/KIKs7a5w9k+kBnrlHFM/8sJtvYv4x5CxjF6lExK8z0Hg6YlnRkIzr003RhuFWf4HFqbjG2mAV8TBDOgI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(52536014)(86362001)(38100700002)(83380400001)(45080400002)(5660300002)(7696005)(55016003)(2906002)(7416002)(33656002)(966005)(71200400001)(44832011)(186003)(122000001)(8936002)(508600001)(26005)(4326008)(9686003)(64756008)(66476007)(66556008)(76116006)(8676002)(66946007)(6916009)(54906003)(66446008)(6506007)(53546011)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S25CMnBVUS9TMnI3K3oxMEUvVVNzUkJWakk4KzYzaitLaDNUODdyVjFTdWdm?=
 =?gb2312?B?eUhBZDQ1bXlTaDBLUTBMTXpiSDlSN0g4WnBlZzlxVDl0MDVEV0hEOVEzNUE1?=
 =?gb2312?B?ZmY3d1JqNy9aR3grRVRnZXRWdHJKR29ZN1FPZEc3eStJbjZVM3VmS2ViR1dp?=
 =?gb2312?B?WnlpU3AzYU0zUHZzc3FWMXVIMkZMNHkyRGk2RGhSN3EzaVpUbnR2ak83KzNy?=
 =?gb2312?B?aWdnZDBNQyttSjVDNnBSakNHRGN0OEY3ZVAxL21lOFVkZFA4S1dIWVpEMW9I?=
 =?gb2312?B?TXovdzByMjNUdU1HTGlFeC94MWlhbzd5NEwxdHVvd0dvemxiS2FONG0zQWwx?=
 =?gb2312?B?aE43QS9odk52eGdQMDBGeEdxbmFEUW91Q0hYQXpOKy9FaWRDeHRxQyt5VVJY?=
 =?gb2312?B?RGpITGJzZ1hnYkxTZFcvdWUvVUxMR054TmQ1ZURJYUhpV3FndTdPZGhwV2Ew?=
 =?gb2312?B?bzNXRWhWdWluR3lGbzVPOW5raUZHZkRjSnpGcVIxUjFNdHdxQ3NLSmxTeDFL?=
 =?gb2312?B?U3JKdXdPZERIeFphdFVHa0NpVml2aVdqN3lGSlc5MDF5R2JZY0txTmRubkJu?=
 =?gb2312?B?a29sRy9xY0J2ZUZsdjZlV2VseGpUSnlQZERONjdPMEw4MjE3L0RDQUN4dGVP?=
 =?gb2312?B?ckwvbWNrclZNLzZZT1ZYUzh0ZE04czdOOVRvdXIzbktQcjY1NXB3cXdxayto?=
 =?gb2312?B?K2FpOU5pa2krME5qSC9zRTl6Qlo2UmVpRk9qU2EvOHl4NjJ0YkxaWlZlbjU3?=
 =?gb2312?B?N2YvSXUzdUVlS2pMU1VMOG9lTWVVTURFbjhTQXd1WmZwU28wcXpWKy9oZ1hq?=
 =?gb2312?B?M3BOZHVTVE0wQlRTcVB5MHZLUzVET0lOMHl2VTh4T2NJV0FoRGVpMVMrVHRi?=
 =?gb2312?B?OC9XQllKNjgrbzBNSDE2d2JYdWMvUVNBU0ZvcVFpNWJDeUs0SFlJV2tVejk5?=
 =?gb2312?B?UXVnM01MYmMvdEZQNGxRYXVrRFg1U2VhaGw3MHExMGQ4dkxwem4rVUJzcFZ4?=
 =?gb2312?B?Q2VUa0pkbTRXMXF1OXF6MkdRNEtLTUFKOS9POHpKK2xpVDQwQmtpd1FJaGhl?=
 =?gb2312?B?RzVBb053cEZXYnhjVHRVN0pOdURDUXNrM2s4WUJ2Vmg2d3ZFTjZiYnVkQ2lz?=
 =?gb2312?B?RzllZktnSUQ2QStjWGxrY0V2KzR5YVo5RFY5cXQxQTBUNEVKVEZYL20zYU02?=
 =?gb2312?B?N2hkVEsxTXhyNEUzNFE4UVNmc21CS3dBWnVnbmN0R1NKMGJxTlhuVWRpeEhK?=
 =?gb2312?B?Tk4zRHZ6Uzgwa1Z1eXhUODhVT1dSNG9xYko1UDhscVJuN2wweGNSTWpBT3NG?=
 =?gb2312?B?VkhnbDhHc01BNVFKRlQrUWMwUFFYY1l3OHRLbFBKYm5xN1dhL1lRcHlWbEpj?=
 =?gb2312?B?VXVkRitPeW1uT1p1UEk3QzFCMnUrNFdHL2UrMzNWVFN3V2JKYXRrZjIrWWU4?=
 =?gb2312?B?S0puek5kbk5oYit4SjFTOVZyUmpJd0JtUXBlTGZ6THB1Y1VnRmRtYXEram9x?=
 =?gb2312?B?bUtMRTd4WlpydHFod0NsYmppSkVXdmFScHgwbEhPWEU0UFNKTGg1TGxRNCs2?=
 =?gb2312?B?TENQWjBiL1QxNWdLRkFxTGpza1Mvd0tmZVFQSGtFdng0NTM3Ulc1eE1UR2hw?=
 =?gb2312?B?Rld5dGZaSlNncE9mOGpPdWJZRU9IQVcyeml6TlVOcERuSHhVb3hrSU5jbGJT?=
 =?gb2312?B?Y1NaZnhBZGxyV1Q4MTVtZGlET3JFUFRDOC9jbmJWUythbitDTFpSY3R3RTFM?=
 =?gb2312?B?cXJRNFVza0FoRzE5NDZlaEJrWTNWL2FNdDVqT0t0K0l5ZURGN254K09pdDFO?=
 =?gb2312?B?NDF2dGpMUE8zOE1oV0VSbGpKcnBFVlVBWm8rcEJCeSs0eDR1ZUIxV3Y1RWwr?=
 =?gb2312?B?TTBMT1Qrb3NEMXRzbUx4aXh6VUlsLzNQbDBycWRlYlVJTGNOUjVsbFpwOUhh?=
 =?gb2312?B?dVVxT1pMNzA1Y2dPck1IRU9LMkhFaFJLZTQ5R2FwZkNySFZYQnNVdTdRTGVz?=
 =?gb2312?B?RHNZRzlCR2dpQzJTUU91cHJ5bU9TU1hhY1ExT2hvR1NRYVA4dnVGaVd6L3hV?=
 =?gb2312?B?bHgweG1Pb2RoK202UTRYbUlvZGIyaGRCNjZpb09CM2xoVFBFS0VIOGN1MnlB?=
 =?gb2312?B?T3RnUzFGdmQwZStwUEFOcml3U0VFVXM5dklCMjlzdnZjUjZRb3U0eTA0cXlt?=
 =?gb2312?B?OHhZdVJxT1dwQk5wa0hyTkdKNHpwMVRXTWg5TlpycHdNNXRkaVpTMk5vYmpS?=
 =?gb2312?B?UTFUVjZtRkh4UDNSTnloQkorYURvbm00T3dwcEF4eDJOb2tUY2YxL05vMjk5?=
 =?gb2312?B?cG01K09CWmZrTWNwZW1GVW9VYVlXTlpCNkRXbXBQak82UWwwUEpYUT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95ea027-ec35-43fb-eff9-08da24f76881
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2022 07:03:45.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGRD/LGeDztYx58Zw1zZl+B8PP+ny2P1iGBMRaCuJXGugsHA1OayF10kqc05umn1Saz/7TfYopaGZaSIAQBgjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IDIwMjLE6jTUwjIxyNUgMTc6MDcNCj4gVG86IFNoZXJy
eSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IG1pY2hhbC5zaW1la0B4aWxpbnguY29t
OyBTaHViaHJhanlvdGkuZGF0dGFAeGlsaW54LmNvbTsNCj4gbWNoZWhhYkBrZXJuZWwub3JnOyB0
b255Lmx1Y2tAaW50ZWwuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOw0KPiBycmljQGtlcm5lbC5v
cmc7IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8yXSBFREFD
OiBzeW5vcHN5czogcmUtZW5hYmxlIHRoZSBpbnRlcnJ1cHRzIGluDQo+IGludHJfaGFuZGxlciBm
b3IgVjMuWCBTeW5vcHN5cyBFREFDIEREUg0KPiANCj4gT24gVGh1LCBBcHIgMjEsIDIwMjIgYXQg
MDk6NTM6MTNBTSArMDgwMCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiBTaW5jZSB6eW5xbXBfZ2V0
X2Vycm9yX2luZm8oKSBpcyBjYWxsZWQgZHVyaW5nIENFL1VFIGludGVycnVwdCwgYXQgdGhlDQo+
IA0KPiBUaGlzIGFsc28gbmVlZHMgdG8gYmUgbWFkZSBodW1hbi1yZWFkYWJsZTogZm9yIGV4YW1w
bGUsDQo+ICJ6eW5xbXBfZ2V0X2Vycm9yX2luZm8oKSByZWFkcyB0aGUgZXJyb3IgaW5mb3JtYXRp
b24gZnJvbSB0aGUgcmVnaXN0ZXJzDQo+IHdoZW4gYW4gaW50ZXJydXB0IGZvciBhIHt1bi0sfWNv
cnJlY3RhYmxlIGVycm9yIGlzIHJhaXNlZC4iDQo+IA0KPiA+IGVuZCBvZiB6eW5xbXBfZ2V0X2Vy
cm9yX2luZm8oKSwgaXQgd2lydGVzIDAgdG8gRUNDX0NMUl9PRlNULCB3aGljaA0KPiA+IGNhdXNl
DQo+IA0KPiBVbmtub3duIHdvcmQgW3dpcnRlc10gaW4gY29tbWl0IG1lc3NhZ2UuDQo+IFN1Z2dl
c3Rpb25zOiBbJ3dyaXRlcycsDQo+IA0KPiBQbGVhc2UgaW50cm9kdWNlIGEgc3BlbGxjaGVja2Vy
IGludG8geW91ciBwYXRjaCBjcmVhdGlvbiB3b3JrZmxvdy4NCj4gDQo+ID4gdGhlIENFL1VFIGlu
dGVycnVwdHMgb2YgVjMuWCBTeW5vcHN5cyBFREFDIEREUiBiZWVuIGRpc2FibGVkLCB0aGVuIHRo
ZQ0KPiANCj4gIndoaWNoIGRpc2FibGVzIHRoZSBlcnJvciBpbnRlcnJ1cHRzIiAtIG1ha2UgaXQg
c2ltcGxlIC0gbm8gbmVlZCBmb3IgdGhlIFYzLlgNCj4gbWFya2V0aW5nIGJsYS4NCj4gDQo+ID4g
aW50ZXJydXB0IGhhbmRsZXIgd2lsbCBiZSBjYWxsZWQgb25seSBvbmNlLCBzbyBuZWVkIHRvIHJl
LWVuYWJsZSB0aGUNCj4gDQo+ICJUaGVyZWZvcmUsIHJlZW5hYmxlIHRoZSBlcnJvciBpbnRlcnJ1
cHQgbGluZSAuLi4iDQo+IA0KPiA+IGludGVycnVwdHMgYXQgdGhlIGVuZCBvZiBpbnRyX2hhbmRs
ZXIgZm9yIFYzLlggU3lub3BzeXMgRURBQyBERFIuDQo+IA0KPiBJIHRoaW5rIHlvdSdyZSBjYXRj
aGluZyBteSBkcmlmdDogb3VyIGNvbW1pdCBtZXNzYWdlcyBuZWVkIHRvIGJlDQo+IHVuZGVyc3Rh
bmRhYmxlIGFuZCB3aGVuIHJlYWQgbW9udGhzLCB5ZWFycyBmcm9tIG5vdywgc3RpbGwgdG8gbWFr
ZSBzZW5zZS4NCg0KSGkgQm9yaXNsYXYsIHRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIHN1Z2dlc3Rp
b25zIG9uIHRoaXMgcGF0Y2hzZXQsIHdpbGwgaW1wcm92ZSB0aGVtIGluIFYzLg0KDQo+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogU2h1YmhyYWp5b3RpIERhdHRhIDxTaHViaHJhanlvdGkuZGF0dGFAeGlsaW54LmNv
bT4NCj4gPiBBY2tlZC1ieTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4N
Cj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIFYyOg0KPiA+IDEuIEFkZCB0aGUgUmV2aWV3ZWQtYnkg
YW5kIEFja2VkLWJ5IHRhZy4NCj4gPiAyLiBBZGQgdGhlIG5ld2xpbmUgYXMgc3VnZ2VzdGVkIGJ5
IE1pY2hhbC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYyB8IDUg
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gPiBiL2RyaXZlcnMvZWRh
Yy9zeW5vcHN5c19lZGFjLmMgaW5kZXggODhhNDgxMDQzZDRjLi5hZTFjZjAyYTkyZjUNCj4gMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gPiBAQCAtNTI3LDYgKzUyNyw4IEBAIHN0YXRp
YyB2b2lkIGhhbmRsZV9lcnJvcihzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2ksDQo+IHN0cnVjdCBz
eW5wc19lY2Nfc3RhdHVzICpwKQ0KPiA+ICAJbWVtc2V0KHAsIDAsIHNpemVvZigqcCkpOw0KPiA+
ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgZW5hYmxlX2ludHIoc3RydWN0IHN5bnBzX2VkYWNf
cHJpdiAqcHJpdik7DQo+IA0KPiBXaHkgdGhlIGZvcndhcmQgZGVjbGFyYXRpb24/DQo+IA0KPiBX
aHkgbm90IHNpbXBseSBtb3ZlIHtlbmFibGUsZGlzYWJsZX1faW50cigpIHVwd2FyZHMgaW4gdGhh
dCBmaWxlPw0KDQpJIHdhbnRlZCBtaW5pbWFsIGNvZGUgY2hhbmdlcyBoZXJlLCBidXQgaWYgeW91
IHRoaW5rIGl0J3MgYmV0dGVyIHRvIHNpbXBseSBtb3ZlIHtlbmFibGUsZGlzYWJsZX1faW50cigp
IHVwd2FyZHMsIEkgd2lsbCBkbyB0aGF0IHdheSBpbiBWMy4NCg0KPiANCj4gQWxzbywgZm9yIGJv
dGggZml4ZXM6IGRvIHlvdSB3YW50IHRoZW0gYmFja3BvcnRlZCBpbiBzdGFibGUga2VybmVscz8N
Cj4gDQo+IEkgdGhpbmsgeW91IGRvIGJlY2F1c2UgdGhleSBsb29rIGxpa2UgeW91J2Qgd2FudCB0
aGF0IHYzLnggc3VwcG9ydCB0byB3b3JrDQo+IHdpdGggb2xkZXIga2VybmVscyB0b28uDQo+IA0K
PiBJZiBzbywgcmVhZCB0aGUgc2VjdGlvbiBhYm91dCAiRml4ZXM6IiBpbiBEb2N1bWVudGF0aW9u
L3Byb2Nlc3Mvc3VibWl0dGluZy0NCj4gcGF0Y2hlcy5yc3QNCg0KTXkgZml4IHBhdGNoZXMgYXJl
IGJhc2VkIG9uIERpbmgncyBwYXRjaDogZjc4MjRkZWQ0MTQ5ICgiRURBQy9zeW5vcHN5czogQWRk
IHN1cHBvcnQgZm9yIHZlcnNpb24gMyBvZiB0aGUgU3lub3BzeXMgRURBQyBERFIiKSwgYXMgdGhp
cyBwYXRjaCB3YXMgaW50cm9kdWNlZCBzaW5jZSBMNS4xNywgaXQncyBxdWl0ZSBuZXcsIHNvIEkg
dGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBiYWNrcG9ydCB0aGVtIHRvIHRoZSBzdGFibGUga2VybmVs
cy4gVGhhbmtzfg0KDQpCZXN0IHJlZ2FyZHMNClNoZXJyeQ0KDQo+IA0KPiBUaHguDQo+IA0KPiAt
LQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMuDQo+IA0KPiBodHRwczovL2V1cjAxLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwZW9wbA0K
PiBlLmtlcm5lbC5vcmclMkZ0Z2x4JTJGbm90ZXMtYWJvdXQtDQo+IG5ldGlxdWV0dGUmYW1wO2Rh
dGE9MDUlN0MwMSU3Q3NoZXJyeS5zdW4lNDBueHAuY29tJTdDOTFkM2EwOGM0ZTANCj4gZDQzYWVh
YzkxMDhkYTIzNzY0YWVjJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
DQo+IDAlN0M2Mzc4NjEyODgyMTk2Mzc3OTUlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TA0KPiBqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk1uMCUzRCU3QzMwMDAlN0MlDQo+IDdDJTdDJmFtcDtzZGF0YT13bkN2clpKMiUyRlpLZCUyRmYy
WDV4cHRFZzd6ZkRxeTVzTG15RENxOFJoM1FCDQo+IE0lM0QmYW1wO3Jlc2VydmVkPTANCg==
