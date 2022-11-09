Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6B8622A4A
	for <lists+linux-edac@lfdr.de>; Wed,  9 Nov 2022 12:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKILVs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Nov 2022 06:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKILVr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Nov 2022 06:21:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76B0BD7;
        Wed,  9 Nov 2022 03:21:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niREZKmCrkhrinvhr5+g3NfHNCgW2O+k0vtgwoJWcAvRSj2eWx3Ox1LGdT4ahbljwhvzPGxxd2EbxOUbPH6vj1B5aAmIN7s6E8VvgHABFypJ4l5NnaAzoCnfHehWS21plg8VlOXcvDS1kY/ybYzjG8N0m9YE+vI7MuEPt6ki8FQjZWtBhPdVH4Z1rHE89Xl2KtGQZi/GC9xXVZUYcHouG9fnaQPpYlTDapGgeUK1FVViQRNibPgeYs6dzZ0JWJkZDWl43B4my9DKIBGFpRLY98w+Kp+YRCFzTUoexwQ3ZmCJICLSau1dneP/cCSTPOY0jhp0oNbWYW0lfXMt0zEJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge0evTv1z8Sy9stT0IsVCKM3WPADezSqVj7q3ZjulQM=;
 b=OuzQAf8WcXG4z5R8qiHQ88t+YIkhVwDCdqW+dAE/36NzZQ7mAaiuI7MATzwKu7MNHJjhjqh/wF7MN3BW0cu/8thVqQbY7do+qYWbnP/KHFdDFCB7yiNUeKLHcyrNfzmWHiUi6l6GW0+P6jIRl+OH/p57C3zULiGBurFlMN4U8RIBgV08ONQdyZMV9bhgU5MPshXdkQiiGNlpWH2cPBaqnu1RO22dv+6ZiS0rp6aBYsQdOmATevMO733gfOe+qQHbykXviUVF/PLLrt8hNRy+CV86Zf24Ae+megCTxTdCnMWA+h20RXrWrniizMJnIOq30HSDbLW5CZ1w1p6jZw6vWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge0evTv1z8Sy9stT0IsVCKM3WPADezSqVj7q3ZjulQM=;
 b=RX1O4zrsH+eAnzOTOoXCskYnOkXD7sBzUbEnrx9Fvj8mKOAvhV2/hVKMk626vIPZcz1fu/HflXNeQ42pcxJ0/7bVRppEY9V+179OhfYWzgWjS2uB8s2Chv2r5DrC97TT/8maUCP7iNsIVKNe1LRpUMF0Yvul+AX8isV5IakezBA=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 11:21:42 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::4dd6:decd:f064:fab9]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::4dd6:decd:f064:fab9%6]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 11:21:42 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v6 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Thread-Topic: [PATCH v6 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Thread-Index: AQHY7ooITJV7Lta0WkuX4ygDAFBaRq41ZaoAgAET3pA=
Date:   Wed, 9 Nov 2022 11:21:41 +0000
Message-ID: <BY5PR12MB4258CB67B70D71F107EC1E9DDB3E9@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
 <20221102070655.247511-3-sai.krishna.potthuri@amd.com>
 <Y2qiRoiYepte/R4W@zn.tnic>
In-Reply-To: <Y2qiRoiYepte/R4W@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|PH8PR12MB6915:EE_
x-ms-office365-filtering-correlation-id: b7802a9c-004c-47ab-bece-08dac24493cf
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5OfSPgzycEUrLMPmjz3EsI+IR6Zj4e1AdVWKs0iZUL2SM/vb7OytwZuY0EevWrmHVEXcEXOVvIf0EDuy8SryyOahlMimFo2AjnyFy77bSe6JyrWSiwWunJhf/1Bq1K975Hq4T501zokSCybyXxBf6HleCL9srk9OY0kz+ee4LLoVs5+UQ+5CacK7WDlfa8mf9QOWEd7nif+Pbp60RP27WQRlnpRhOn88K0qfiQn5CduUqY/g52ADzpeR0qPzYCQRsaVSq1Itv/sAm6kELOQswEXmSuIilctMiTpS/kM3ekK3GcgiMIv/DdNrvnwQT1rIJnHkqc3So7q+cajg4a7ZQS5X1sFWsi5CgxGjmIzlHf6QNFVVB8Vwmp7VRAY47qWmihOE0t9GJxbC9QoS0OgLxuVmxcTNPOKrfiDKUxGi7YC7mjRrvWVFNHLNRhtb+e5MVYuDXktfyM4zHe6bJQFzBBENaFwtM4APXyH8nM2KUqhWvEKd7wB/iylU4SgH/w2kixDjUhmwIUChtEWhAQOrhh5nrQBt/PlKxDZo+nNQvyj+yoKntytfaE0wT0/+PLrWvvrCrclRIjl9nhE/UGgpmeKxUeD/6PnhbhWKsURmKMZv6A126E5a2VDuudOVOLTjdyZ4lF/60H5BXBEGl3Y62YtIzVvPRadXDiKIPnM8xjhA+2APwcZfa8yRou/GUSF6IZNSIyUl4LmNfUp3IZoIHYO8aBCdKrPDF8RIzP02Q4YewkdQInc2mJXJx7p40INgfVsIm2DC1zVo/1m+jTiBMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(122000001)(33656002)(55016003)(478600001)(38100700002)(38070700005)(83380400001)(86362001)(52536014)(186003)(9686003)(7696005)(7416002)(2906002)(6506007)(53546011)(5660300002)(71200400001)(26005)(54906003)(41300700001)(8936002)(316002)(66556008)(6916009)(66946007)(76116006)(66476007)(8676002)(64756008)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnA4RXBSYXVsOGRJNGIwY1NKUjBvZHVwVzBjaHN5MU51ODFMeEVIa0N1bkpX?=
 =?utf-8?B?UUsxWncwQ0d3WUhUSjdaaHB5QmxTMHczSFM5UElNZ2I4U0N6WVk1OHhBbkhn?=
 =?utf-8?B?akhmTytoZ0l0YmdvMTlpanU3b2czTEZES0hTaHRaZmFVb3BidXZFZ1BQVDNo?=
 =?utf-8?B?Sk9KeGFaQ3ZtRGtPR3NRZXN2WEQwSEFILy9sYzFCY3laZzdldXFUSElkZ0lN?=
 =?utf-8?B?YkpjL0VFYldwSFZraWdjcFFaQ3JkNk84RWx3aDMwZVRVRko5dUNUVEVQWVdV?=
 =?utf-8?B?SEROd3RRd3BDRExRY1NRMG45eEpOaCtVejBzUWs0SXJ3aHhBNzNMS0MzM2pS?=
 =?utf-8?B?R2ZVSG1yaG5xdDZoNng3ZHZpcVd6RmV5Ym50UHlMNkxrb2J3MDI3Z3dmanRT?=
 =?utf-8?B?djFNQWhjeUduaHByd3QvcWJ1aW10UEpMeEpIdHljTnZSVXBjTU5PQTRNZjBZ?=
 =?utf-8?B?ZkQ2Yk9sSzh3Nk0yYkp5clcwM0FnNE5ENjRWZmsrci9CaVV1RzlHQjhtUVA3?=
 =?utf-8?B?OE95Z2UrckpmQit3Mmc3Q012ZWl5eFR5VURJT2hIUkl4V1lvT1Z2dGRKdkRx?=
 =?utf-8?B?T0pKeGhLSm9IQndQZnhHb3k5eHYyU09xK0dYUTluZmM1NVZzOHdmdWdGMXhx?=
 =?utf-8?B?WGUxNmJGMWxiRFgyeld4NDZEdWVNTVVieTduc2g3OHE2aXRjdStpUG5nbExO?=
 =?utf-8?B?NDN2OTFsZWlmV0xQVDZUOXVNUjRrSmY0dHY5OHQyaWgyOFhGdUNLQUF1VlZL?=
 =?utf-8?B?YldKK1ZiMXVDZENUMkhoTVpSZG9JZ2JPQmZJakhJaWlOaEcvZzZ0ZUdQNy9W?=
 =?utf-8?B?UVEyNmxBdGRmaG5DTXNOUkNLYXJGOUw5dXd6aWwrSW5WZ3Yxc2JsdUVvZDFQ?=
 =?utf-8?B?b2ZMc0V5ajQ5ZFBTc25odnV6SmpTSW9Rd2RTYjZYc0V2UHQreUpGSHN0Znk5?=
 =?utf-8?B?R0dwaWowbVMvV3pqWXVOU1lWTVYzVTMzbjhGeTJNczl6OXcyMzU1Ly85MHoy?=
 =?utf-8?B?Q1VYNDlLTUs3c3hsMmFVZ3N6Y3lBM3ZIRHd1WU85TFNCQS8zR3QyTWpEdGg4?=
 =?utf-8?B?MHNCNk8rRmw3aTg1SjJJUS9Pc2hmbFRLL2tPQ1Y3Y0xpZ280MHBUU0xyL3Mz?=
 =?utf-8?B?OC9ZS1BLczA3NEE2dlJjYTZ2NWhscU5PR3dRMFZOYkJzTEFLN1NlazJoQmp4?=
 =?utf-8?B?UU5iSXdIK3Y2bGdXZ3J2cFQ4ZWJvVnZ2YjFvRTdldXhkKzR5ZExIWXhvb0U4?=
 =?utf-8?B?VDdmeWRKbFZzaVdnTnN4V1R4UjNqK3B5ZWUvaWNKTUhOZ1ZzWDR2SjBWTmw4?=
 =?utf-8?B?bXlEUWJZRklvZDBNRXVOUnRONHlYL0hycU1QbWI0NEFqOFA2ZS94UWFMWmRl?=
 =?utf-8?B?QWdkN0lzNkxydVVLOVQzNE1DYVJKMzBnV05ydngycW9qMzl4cTkzWUpVc0VM?=
 =?utf-8?B?WVFSMkZCV3d4VU53RnM0YkQrWldkdkFXV2ZjdWVUOWdiQnNaZm8zTFhjc1BO?=
 =?utf-8?B?K1EyTlZqVjFlNUVDRWdvTDVPNWVjYTRBMTUwQlZGYVlvdUN5TGZ1SWJzcWxE?=
 =?utf-8?B?WUsvU1NHR3VneW0rM2JMTlJRK1RVbHZiVFl6ZU91RjJmYlF1QUQrWWQzSDdE?=
 =?utf-8?B?dEtBOHhjdVNqOHAyZzlFTlV6NG9SUnZKdnlXTlYwRkVPb0JENG5jUDk2Z3dj?=
 =?utf-8?B?TmQycTUySCtpdERpemZ1U0lEQmp6bm51cDBFNytkZEFtemhxUmhGcElxZjFT?=
 =?utf-8?B?eEtyaGRPQitQSnROV2F3UUxjV1NzWE52TWdwaEU2NGdPbkhHMFpGRE5FQlpE?=
 =?utf-8?B?YnVyTTBHa2hBa2NQMjJGNFpFcXRuQm5hQkRmQ3RIYmtCUnYvdk95b0FIV2dt?=
 =?utf-8?B?dG8rdzNDYmJHVkR6cnM4c0VtY3hVYTJ2YUVFRDdDbVJLZGlid3hrWnJjMlVU?=
 =?utf-8?B?N1BmaG02TlpMMjhIMFdoZDlPZ2hQY1c1YkpWdzdFK0Ivb3luMG5ScTV2bisv?=
 =?utf-8?B?YzZqY0JQOTVBRVZjZnljV0NJcmQ3UThKZ2p6TkViTmlKWHNPd2FUVDBSeUpp?=
 =?utf-8?B?VlJQd0NubENqTjRTY2xWeVFMaWx4dmRFNDdoQUJoNmdhUTRFcDBzczFVN2VZ?=
 =?utf-8?Q?oMJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7802a9c-004c-47ab-bece-08dac24493cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 11:21:41.9308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/IpScRUa+h0W0neQES9LqwUGqCp9sTTkKYlvoSRRS+GpmxK/fyUjf4bRD9qZuN4eDVhFN5MhifwuERR1xx0Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNs
YXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgOSwg
MjAyMiAxMjowOSBBTQ0KPiBUbzogUG90dGh1cmksIFNhaSBLcmlzaG5hIDxzYWkua3Jpc2huYS5w
b3R0aHVyaUBhbWQuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
Zz47IE1pY2hhbCBTaW1law0KPiA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+OyBNYXVybyBDYXJ2
YWxobyBDaGVoYWINCj4gPG1jaGVoYWJAa2VybmVsLm9yZz47IFRvbnkgTHVjayA8dG9ueS5sdWNr
QGludGVsLmNvbT47IEphbWVzIE1vcnNlDQo+IDxqYW1lcy5tb3JzZUBhcm0uY29tPjsgUm9iZXJ0
IFJpY2h0ZXIgPHJyaWNAa2VybmVsLm9yZz47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsNCj4gc2Fpa3Jpc2hu
YTEyNDY4QGdtYWlsLmNvbTsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBEYXR0YSwN
Cj4gU2h1YmhyYWp5b3RpIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT47IGtlcm5lbCB0ZXN0
IHJvYm90DQo+IDxsa3BAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDIvMl0g
RURBQy96eW5xbXA6IEFkZCBFREFDIHN1cHBvcnQgZm9yIFhpbGlueA0KPiBaeW5xTVAgT0NNDQo+
IA0KPiBPbiBXZWQsIE5vdiAwMiwgMjAyMiBhdCAxMjozNjo1NVBNICswNTMwLCBTYWkgS3Jpc2hu
YSBQb3R0aHVyaSB3cm90ZToNCj4gPiBBZGQgRURBQyBzdXBwb3J0IGZvciBYaWxpbnggWnlucU1Q
IE9DTSBDb250cm9sbGVyLCB0aGlzIGRyaXZlcg0KPiANCj4gU28gYSB3aGlsZSBhZ28geW91IHNh
aWQgdGhhdCB0aGlzIGRyaXZlciBpcyBmb3IgdGhlIG9uIGNoaXAgbWVtb3J5IGNvbnRyb2xsZXIu
DQo+IElzIGl0IHBvc3NpYmxlIGZvciBzdWNoIGEgc3lzdGVtIHRvIGhhdmUgYW5vdGhlciBtZW1v
cnkgY29udHJvbGxlciB0b28gZm9yDQo+IHdoaWNoIGFub3RoZXIgRURBQyBkcml2ZXIgZ2V0cyBs
b2FkZWQ/DQo+IA0KPiBCZWNhdXNlIHRoZSBFREFDIGNvcmUgLSBhdCBsZWFzdCBvbiB4ODYgLSBh
c3N1bWVzIHRoYXQgYSBzaW5nbGUgZHJpdmVyIHJ1bnMgb24NCj4gdGhlIHN5c3RlbSBhbmQgSSBk
b24ndCB0aGluayBJJ3ZlIGV2ZXIgaGFkIHRoZSBjYXNlIHdoZXJlIHdlIG5lZWQgbXVsdGlwbGUN
Cj4gZHJpdmVycy4gQW5kIGluIHN1Y2ggY2FzZSB0byBhdWRpdCBpdCBmb3IgY29uY3VycmVuY3kg
aXNzdWVzLg0KPiANCj4gU28gSSBndWVzcyB0aGUgcXVlc3Rpb24gaXMsIGNhbiBhIHN5c3RlbSBo
YXZlIHp5bnFtcF9vY21fZWRhYyBhbmQgc2F5LA0KPiBzeW5vcHN5c19lZGFjIG9yIHNvbWUgb3Ro
ZXIgRURBQyBkcml2ZXIgbG9hZGVkIGF0IHRoZSBzYW1lIHRpbWU/DQpZZXMsIHdlIGhhdmUgdGhp
cyBzY2VuYXJpbyBvbiBYaWxpbnggWnlucU1QIHBsYXRmb3JtIHdoZXJlIHdlIGhhdmUgYm90aA0K
dGhlIGRyaXZlcnMgKHp5bnFtcF9vY21fZWRhYyAtIE9DTSBDb250cm9sbGVyIGFuZCBzeW5vcHN5
c19lZGFjIC0gRERSDQpNZW1vcnkgQ29udHJvbGxlcikgcHJvYmVkIGF0IHRoZSBzYW1lIHRpbWUu
DQpXZSB0ZXN0ZWQgdGhpcyBzY2VuYXJpbyBvbiBvdXIgcGxhdGZvcm0gKGFybSBiYXNlZCksIGFu
ZCB3ZSBzZWUgYm90aCB0aGUgDQpjb250cm9sbGVycyBnZXR0aW5nIHByb2JlZCBhbmQgdGVzdGVk
IGJ5IGluamVjdGluZyBlcnJvcnMuDQoNClByb2JlIGxvZyBmb3IgYm90aCB0aGUgY29udHJvbGxl
cnM6DQp4aWxpbngtemN1MTAyLTIwMjIyOn4kIGRtZXNnIHwgZ3JlcCBlZGFjDQpbICAgIDEuNjQy
MjI1XSBFREFDIERFQlVHOiBlZGFjX21jX3N5c2ZzX2luaXQ6IGRldmljZSBtYyBjcmVhdGVkDQpb
ICAgIDIuMTUxNzgxXSBFREFDIERFQlVHOiBlZGFjX21jX2FsbG9jOiBhbGxvY2F0aW5nIDIyNzIg
Ynl0ZXMgZm9yIG1jaSBkYXRhICgxIHJhbmtzLCAxIGNzcm93cy9jaGFubmVscykNClsgICAgMi4x
NTE4NjJdIEVEQUMgREVCVUc6IGVkYWNfbWNfYWRkX21jX3dpdGhfZ3JvdXBzOiANClsgICAgMi4x
NTE5MTJdIEVEQUMgREVCVUc6IGVkYWNfY3JlYXRlX3N5c2ZzX21jaV9kZXZpY2U6IGRldmljZSBt
YzAgY3JlYXRlZA0KWyAgICAyLjE1MTk0NV0gRURBQyBERUJVRzogZWRhY19jcmVhdGVfZGltbV9v
YmplY3Q6IGRldmljZSByYW5rMCBjcmVhdGVkIGF0IGxvY2F0aW9uIGNzcm93IDAgY2hhbm5lbCAw
IA0KWyAgICAyLjE1MTk3OV0gRURBQyBERUJVRzogZWRhY19jcmVhdGVfY3Nyb3dfb2JqZWN0OiBk
ZXZpY2UgY3Nyb3cwIGNyZWF0ZWQNClsgICAgMi4xNTIwMjBdIEVEQUMgTUMwOiBHaXZpbmcgb3V0
IGRldmljZSB0byBtb2R1bGUgMSBjb250cm9sbGVyIHN5bnBzX2Rkcl9jb250cm9sbGVyOiBERVYg
c3lucHNfZWRhYyAoSU5URVJSVVBUKQ0KWyAgICAyLjE2MTk1Ml0gRURBQyBERUJVRzogZWRhY19k
ZXZpY2VfcmVnaXN0ZXJfc3lzZnNfbWFpbl9rb2JqOiANClsgICAgMi4xNjIwMzVdIEVEQUMgREVC
VUc6IGVkYWNfZGV2aWNlX2FkZF9kZXZpY2U6IA0KWyAgICAyLjE2MjAzOV0gRURBQyBERUJVRzog
ZmluZF9lZGFjX2RldmljZV9ieV9kZXY6IA0KWyAgICAyLjE2MjA0M10gRURBQyBERUJVRzogZWRh
Y19kZXZpY2VfY3JlYXRlX3N5c2ZzOiBpZHg9MA0KWyAgICAyLjE2MjA1MF0gRURBQyBERUJVRzog
ZWRhY19kZXZpY2VfY3JlYXRlX2luc3RhbmNlczogDQpbICAgIDIuMTYyMDY1XSBFREFDIERFVklD
RTA6IEdpdmluZyBvdXQgZGV2aWNlIHRvIG1vZHVsZSB6eW5xbXAtb2NtLWVkYWMgY29udHJvbGxl
ciB6eW5xbXBfb2NtOiBERVYgZmY5NjAwMDAubWVtb3J5LWNvbnRyb2xsZXIgKElOVEVSUlVQVCkN
Cg0KUmVnYXJkcw0KU2FpIEtyaXNobmENCg0K
