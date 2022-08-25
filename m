Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2C05A0BE0
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 10:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiHYIuX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiHYIuV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 04:50:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2ECA345E;
        Thu, 25 Aug 2022 01:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SENoqpS4535GtOuLSvKi+uu9reECF2GOBULUc8r19bX8tmBg5rFjh/sUXCBvhe9aRrrhOX1o6yI11OalwpaFWDoWxq451LXT1me/sfNmzNeU0TChAK9meHmKkmrlYyVx9Mdldz3ROyFRj0Y1KIH1/DUXJ2KRsmYO/9IXX2loog7PMKB0e7iIPw4RdlplMzqdztGtOajsIyLYgh4WXws5PFn458AhDT+Uee5jjbvpGJxcgLZbhjKBSjLUexo4QsccSg4PTRDpg/19lB8wvdsuy4gngNSLFV7HWtOnKpkHRei2YqVhWcpGPRRD+fAeVq1RbTacj0c00IBFq6x1JPtxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0RA2oXS1xvOrZgKhUflnSXsUSxa1Rl4YSyjpG0jJwY=;
 b=Xl+zjKjeqjCBEGTBH29jbYmm1G1/C0eV1VdmVkMVoXVaVd/lyEGODx3EJZpA0xyrBWoOTjtqflX7lKYDvKrE9bt0y1JXgf6uumDxVjd+CwFpvJCAMoOScKX6Fqz0z6g+OtjdgRHoD03cvQ3KC4LtaIwlZyU/AmECDUg+s1ke6G2tz2v9w7OpAMGB41esOimgBDaKpwaHp+E31AKl7MHnrf4Fk4zDeov+zfABqmvvOYmYmGJOPwX1fGYs2E29mqWL8brRoPmE95q4fhHLpjOsvwN/B6VckYyF76x2p4iuPbmQNhvRqBkrTygwqdS8kLT+Vvnut7Pl9bq3xqBsa9i1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0RA2oXS1xvOrZgKhUflnSXsUSxa1Rl4YSyjpG0jJwY=;
 b=H2DyVYXmOINvun3b3fngS0P5FaCwlp2ABWhTw8BNc9PqDYqhtzEuoN+k/q72JeBZiSOAIGsPqdwroSAMmRvrE6Jv+4UQAI+X+IbaF1hgLHskA2TdEh5LWM+EM0z1TBIQSZs7iWcli67QYjPzhxPT0N+omRAEylXITFtz57wwJws=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 08:50:15 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::28ea:aeb4:301e:c253]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::28ea:aeb4:301e:c253%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:50:15 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP
 OCM
Thread-Topic: [PATCH v2 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP
 OCM
Thread-Index: AQHYth6KqyAUdiEn00m4ldEkzGayN628cH+AgALfk5A=
Date:   Thu, 25 Aug 2022 08:50:15 +0000
Message-ID: <BY5PR12MB42589769EF9702D7A0F83989DB729@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220822115821.3907-1-sai.krishna.potthuri@amd.com>
 <20220822115821.3907-2-sai.krishna.potthuri@amd.com>
 <52fa28d6-4d48-bd0c-40e6-4f8855c4eac8@linaro.org>
In-Reply-To: <52fa28d6-4d48-bd0c-40e6-4f8855c4eac8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b666f898-18e5-4564-5283-08da8676d43f
x-ms-traffictypediagnostic: MN2PR12MB4254:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2w6CnOW9+iJFZs0ubIOKP8Lx1ih4m8vdA1rFq5ao+2sRBzXGRxcNmEjYrErQtXQuTHlDG62VNLsl0Tb+OdaECL+ay4AHKLmy896d0YtUiI/AbzX2uXGeUatQVsSceeWM/gcz+37bqY+Ac/tgO1dEF5aDFRF7RsdhNvGPSGYO54zkSbDVjtyjirA3JuNx39F9RmOGIqK4Je/77O8Xz7gFzHzJc+KTmngE8J3WFTgB7ln2K7DcGEMTF6rCMp3oAJ9zQUkNkThu9QZoHeK24Ft59uvpwNK//2Nsd03Kyxrv/WVymYQho+pXzsSubpei5ooHGKG/Vy6vrtE3f6NomGoaUWCerOU7TQ8Sw75dw9OgiHhGNj5j3+G6U/aUFS91+aqsQiL13Yq1zcxSKtmNgI7BaY+AiqV5m18Tip3JECPLHjRhBoZy6i6UHYWNuyzfLAyeRypMQJctUeMiR7lHXA2Ns9afoM7lLV5KJfVpQAebqhwoS2BU6wezw61J1HVT+nLt7t5gRpkNDS0XDxIVAMc4XM8FkmIK+VCG6Fv3hChxVnd7sxcxKOIW3EgCek/Hx37tc9UiHDmbsXe6+mleNZNxg1bqhDvWCOQbpS+HDU9ZJVUHWe1jWbOxppyvWeaw8l4iOcnfyhw3SEiKrIGs+prklQ5be9hyyAKOv5mlypM78AGN+4NmCWdEQxHveh8LKRxyprm2BG8VbhmN9gJtNW0Bw+i3LAg2bH4fQ7sO6WqgXOt7Pa5WdivVRFGpYrn9G6HAk/eIc2W+V74igQMfGFTkmJoG7lduljsIZueVQUEZxNj5j3qPw5+j5bvcxnogfRNAfNbuQ5F3uapYlIMM67N5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(4326008)(316002)(7696005)(64756008)(66446008)(55016003)(110136005)(66946007)(76116006)(86362001)(54906003)(186003)(66556008)(38100700002)(66476007)(6506007)(107886003)(38070700005)(41300700001)(9686003)(26005)(8676002)(53546011)(7416002)(966005)(478600001)(71200400001)(122000001)(52536014)(33656002)(2906002)(5660300002)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NCsxVTBoVGljTUdkUW5SRkw2WEpwM2xucitacjh3WHlpQmZueDVHbzlCK245?=
 =?utf-8?B?aitRZW0ydWpHb2dnVWtabzF2N0tkeGYrOXA2cW9EMll3aVNDY2RBTXFXcFpL?=
 =?utf-8?B?T0F6d1VnUTF6OENqQmFQcHNyazFnbnJxZHRzN3NPWitadU0xTERvdVZwb2wv?=
 =?utf-8?B?YU1Ccmpnb1hsRnJWOW4wN0w0WVdJazk3V3dJb1BuWXFlY1F5WUcvMEpSd25u?=
 =?utf-8?B?aXAxY1R0TjlhWkt5SUczRnJma1VWUXZsREtTM2N0VVZUNk9sa1dNenYwVmd4?=
 =?utf-8?B?Mkp5RU50elJxV3hVMFlCZllJdlB6M3A2cGJXckFGOUxHc2s3N0ZFLzZ0cmRN?=
 =?utf-8?B?MDFPK3B3RTlCWitYZWJDMzlkK1NpNCsrd2ZuWDExMXpQSXN0KzNqRXRvTWZy?=
 =?utf-8?B?Z2lOUFV0TUJJcTJ6Q0JUN3NJRHBVenQ0U25Zdk5NMGRsVkNhVlFaak8zY2dz?=
 =?utf-8?B?ZjR4TVJtSmg1TS9mU3RKSlhISXp4cFBpM25aeW1wYkliZ01zMTJJYTlSYmxs?=
 =?utf-8?B?SkVZUjFCdG11UXgyL0RrV0RmTVZ3WEk4ZHl6T1gxVEZmUWk0OUFrNUhNWHp1?=
 =?utf-8?B?MGR4N3NxUE9hZmY3cytnenJrSXYwV3NVUTdjOURnM3hMcTU0K1d1NmJVNytn?=
 =?utf-8?B?K0FQQWl4bzNuYkFQWDZ3WlZxUTM1RnNtZTVhQi9OaEJlOGpsalJEVWJpaHJ1?=
 =?utf-8?B?clp1NUtBZkx4UnluOW1GMHQ3a29saUJtYU1iOXoxUmV3R0dTSHRYRkJxakRC?=
 =?utf-8?B?aFVhbTlVL3k3cWFycEkvajN0N2NnOVA1alk0NGY1dkRQWEY4MHhOcmFPYUpU?=
 =?utf-8?B?ME9OL0dySUNSUUpXL0xsQ0pzb3FSd0RmUlR5QytLRVNaMStEUjJRUng0ZWhL?=
 =?utf-8?B?ZUZWbVo2bGowWWlYdG4zcHhoMVBrcy9kckh4bFBRVUtXQ3RHd3l6RlNsR0g4?=
 =?utf-8?B?eUg4b2xJbHFjaXJGKzdjelNpTTRQQTNSM21qdlVmQWZMeTFLSTRqbjlKQ2I0?=
 =?utf-8?B?djV4dDZHSzNmSDRJa1M2V0FIdGdIcHprL2tOMkh2eU9EcFl1VXB5cEVscTZK?=
 =?utf-8?B?YjBoMnlHUlkyQmtqbk1yVVpzV3d4ZWllOThoVGJQRkhHMGp1SWxlRHJxelg5?=
 =?utf-8?B?TWJWaHBQL0kwL1hQK2xsUzFDSmY1QVBqR0Z0T1BKT3VTd3cxSWt0c3djZ0Jv?=
 =?utf-8?B?TkdGMGsrZHozK0xSQmo3ZEd1UGxKUTRtTnUrQjRVRGRPTG1UU2RrWWtqOVFF?=
 =?utf-8?B?aVJMUms4M3U4ZkxXZjd2c0NoZFFkK2NyVVUwNktHb01ZZTBkR1phdlBYdEFD?=
 =?utf-8?B?bC9Pem9PZGZLRlEybnIvNTl3bHIyVzZoUk9wQU5YQVNEVmdTakFQNU4wSUlU?=
 =?utf-8?B?eWF4d1NQN2hiOG5iTTdpQXNhNnZ5T3VXYWZFdTFHazdEOWQzYjJacHJGQ1JX?=
 =?utf-8?B?cGUwaUNtMmI5WUtpV05YeDJHbmFaRFBEOWIybUlweW9CcjFKTUhZcng1bzdO?=
 =?utf-8?B?N0dqVWI0ZmFYZzUralp2cktIQmNzeVJtZG9oZEgyQXJKdmoxdGJDNitOZnR1?=
 =?utf-8?B?YUVrQU80US94algwTFNKWUdsM3JKK2o5Z2MwMFI3VVlBVUh0d1l2cy8vSEk4?=
 =?utf-8?B?YmpXejlyZDZGWnhzY1VyMzkvVVN2QUNDT3AzZXlnYmpQOGErLzE0Qi9FSEVE?=
 =?utf-8?B?Um4zemlWR0N0YUlNMEhkUVltcWhsSndya0xFMFM1NHlBOS9kNGlYM1ptSFJh?=
 =?utf-8?B?cFFuTW5mZ0RKSVZsUkNvTDVnbHlHM1k4NG5uYUhrOWhVSTVUL3o1a0lSVC8v?=
 =?utf-8?B?aUJraElWeEsvK0F5eVYvalZyZEpUQjF6L0M3NCtxZFlRN0pLRytRSXFpZGtV?=
 =?utf-8?B?ZXJjNG0wTGl1ejF4bTNKTWxDcDdSUE1HWGZwVndzQm42NWswYVNCN1kwbHZS?=
 =?utf-8?B?eGE3Z1JBV2FTUS9GRWxtbGxRSExvMEdmT25kWVdybDljMlp3anNIOXdYZmp4?=
 =?utf-8?B?bzlsRTIyZUIwa0tLdHQrQ2pLVFNZZGZRUkkvZkI4aDlTN0ZCcHJtWUtEcEdR?=
 =?utf-8?B?ZkpPRXdSNVJOakFtNVJmQkRHOXpZcEFyU2JYVTBYeERmNDFxSEVqMUdnemEx?=
 =?utf-8?Q?f87o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b666f898-18e5-4564-5283-08da8676d43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 08:50:15.1217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LLdjIvegjK9NL9U2oINYGKxa0Id5BvQo/Hi4TCnM2I2YRSoI6fSUAPjYZP/Ci/1TpAiFBJ5x1HTJJKEKpl0FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogVHVlc2RheSwgQXVndXN0IDIzLCAyMDIyIDY6MTcgUE0NCj4gVG86IFBvdHRodXJpLCBTYWkg
S3Jpc2huYSA8c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxy
b2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc+OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbC5zaW1la0B4aWxp
bnguY29tPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+OyBNYXVybw0KPiBDYXJ2YWxo
byBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVs
LmNvbT47DQo+IEphbWVzIE1vcnNlIDxqYW1lcy5tb3JzZUBhcm0uY29tPjsgUm9iZXJ0IFJpY2h0
ZXIgPHJyaWNAa2VybmVsLm9yZz4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsNCj4gc2Fpa3Jpc2huYTEy
NDY4QGdtYWlsLmNvbTsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBTaHViaHJhanlv
dGkNCj4gRGF0dGEgPHNodWJocmFqeW90aS5kYXR0YUB4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IGVkYWM6IEFkZCBiaW5kaW5ncyBmb3IgWGls
aW54IFp5bnFNUA0KPiBPQ00NCj4gDQo+IE9uIDIyLzA4LzIwMjIgMTQ6NTgsIFNhaSBLcmlzaG5h
IFBvdHRodXJpIHdyb3RlOg0KPiA+IEZyb206IFNodWJocmFqeW90aSBEYXR0YSA8c2h1YmhyYWp5
b3RpLmRhdHRhQHhpbGlueC5jb20+DQo+ID4NCj4gPiBBZGQgYmluZGluZ3MgZm9yIFhpbGlueCBa
eW5xTVAgT0NNIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHViaHJhanlv
dGkgRGF0dGEgPHNodWJocmFqeW90aS5kYXR0YUB4aWxpbnguY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFNhaSBLcmlzaG5hIFBvdHRodXJpIDxzYWkua3Jpc2huYS5wb3R0aHVyaUBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvZWRhYy94bG54LHp5bnFtcC1vY21jLnlhbWwgICAg
ICAgfCA0NSArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNl
cnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9lZGFjL3hsbngsenlucW1wLW9jbWMueWFtbA0KPiA+DQo+ID4gZGlm
ZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2VkYWMveGxu
eCx6eW5xbXAtb2NtYy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZWRhYy94bG54LHp5bnFtcC1vY21jLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNjM4OWZjYjdlZDY5DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9lZGFjL3hsbngsenlu
cW1wLW9jbWMueWFtbA0KPiA+IEBAIC0wLDAgKzEsNDUgQEANCj4gPiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0t
DQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZWRhYy94bG54LHp5bnFt
cC1vY21jLnlhbWwjDQo+IA0KPiBGaWxlbmFtZSBzaG91bGQgYmUgYmFzZWQgb24gY29tcGF0aWJs
ZSwgc28geGxueCx6eW5xbXAtb2NtYy0xLjAueWFtbA0KSSB3aWxsIGZpeCBpbiB2MywgSnVzdCB3
YW50IHRvIGtub3cgaW4gY2FzZSBpZiB3ZSBoYXZlIG11bHRpcGxlIGNvbXBhdGlibGVzLCANCmhv
dyB0byBoYW5kbGUgc3VjaCBjYXNlcz8NCj4gDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IFhpbGlu
eCBaeW5xbXAgT0NNKE9uLUNoaXAgTWVtb3J5KSBDb250cm9sbGVyDQo+IA0KPiBTbyB0aGlzIGlz
IGEgbWVtb3J5IGNvbnRyb2xsZXIsIHRoZW4gcGxlYXNlIHB1dCB0aGUgYmluZGluZ3MgaW4gdGhl
IG1lbW9yeS0NCj4gY29udHJvbGxlcnMgZGlyZWN0b3J5Lg0KSSB3aWxsIGZpeCBpbiB2My4NCj4g
DQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFNodWJocmFqeW90aSBEYXR0YSA8
c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+DQo+ID4gKyAgLSBTYWkgS3Jpc2huYSBQb3R0aHVy
aSA8c2FpLmtyaXNobmEucG90dGh1cmlAYW1kLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9u
OiB8DQo+ID4gKyAgVGhlIE9DTSBzdXBwb3J0cyA2NC1iaXQgd2lkZSBFQ0MgZnVuY3Rpb25hbGl0
eSB0byBkZXRlY3QgbXVsdGktYml0DQo+ID4gK2Vycm9ycw0KPiA+ICsgIGFuZCByZWNvdmVyIGZy
b20gYSBzaW5nbGUtYml0IG1lbW9yeSBmYXVsdC5PbiBhIHdyaXRlLCBpZiBhbGwgYnl0ZXMNCj4g
PiArYXJlDQo+ID4gKyAgYmVpbmcgd3JpdHRlbiwgdGhlIEVDQyBpcyBnZW5lcmF0ZWQgYW5kIHdy
aXR0ZW4gaW50byB0aGUgRUNDIFJBTQ0KPiA+ICthbG9uZyB3aXRoDQo+ID4gKyAgdGhlIHdyaXRl
LWRhdGEgdGhhdCBpcyB3cml0dGVuIGludG8gdGhlIGRhdGEgUkFNLiBJZiBvbmUgb3IgbW9yZQ0K
PiA+ICtieXRlcyBhcmUNCj4gPiArICBub3Qgd3JpdHRlbiwgdGhlbiB0aGUgcmVhZCBvcGVyYXRp
b24gcmVzdWx0cyBpbiBhbiBjb3JyZWN0YWJsZQ0KPiA+ICtlcnJvciBvcg0KPiA+ICsgIHVuY29y
cmVjdGFibGUgZXJyb3IuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGli
bGU6DQo+ID4gKyAgICBjb25zdDogeGxueCx6eW5xbXAtb2NtYy0xLjANCj4gPiArDQo+ID4gKyAg
cmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0czoNCj4g
PiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBh
dGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+ICsNCj4gPiArdW5l
dmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiANCj4gSW5zdGVhZCB0aGlzIHNob3VsZCBiZToN
Cj4gYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQpJIHdpbGwgZml4IGluIHYzLg0KPiANCj4g
PiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiA+ICsgICAgbWVtb3J5LWNvbnRy
b2xsZXJAZmY5NjAwMDAgew0KPiA+ICsgICAgICBjb21wYXRpYmxlID0gInhsbngsenlucW1wLW9j
bWMtMS4wIjsNCj4gPiArICAgICAgcmVnID0gPDB4ZmY5NjAwMDAgMHgxMDAwPjsNCj4gPiArICAg
ICAgaW50ZXJydXB0cyA9IDwwIDEwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiANCj4gV2hhdCBk
b2VzIDAgc3RhbmQgZm9yPyBJIGNvbW1lbnRlZCBhYm91dCBpdCBhbHJlYWR5Lg0KSSB3aWxsIGZp
eCBpbiB2My4NCg0KUmVnYXJkcw0KU2FpIGtyaXNobmENCj4gDQo+IA0KPiA+ICsgICAgfTsNCj4g
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
