Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1196B5071E0
	for <lists+linux-edac@lfdr.de>; Tue, 19 Apr 2022 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353835AbiDSPhE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Apr 2022 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiDSPhD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 Apr 2022 11:37:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CE618E05;
        Tue, 19 Apr 2022 08:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSzsdCeh/oXQbHbuiQ7Zl3xpVMFLeMBHWaETgAiUzWiND2Nkb0ItnY/RQPqAsZoC2cciHHJ89W5HaDyNhAeWjwRDX9Vhf6XREWvAk1uTNz522T0K/du++zhoXBoXyLFshhlxfEpddHCYbfc0UxsaESez95Aamtr5awap1Q74l3ywSTg4vK8nBTFj2k3BEBUhGZsSM5wls4mS+afvzJbEdfeOxvsFm9DeXzKEYdu1NjS/yc9S96q46pVfYTuLtsl5D9NFYXNJvqs4RxlLOgkbImsOIjzTehuMwOTCVAu1EdiWUnLZoszvRPiHFTFOoHpCWg1q1o0Jt6F1m8L/YjQqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP1pEhRRpprp6QAYr88+X5ShMsH8fO6yNiXAXKE4frc=;
 b=PvWRGoHTZ4eDevYSG7DgICXPlvg8va2H8UB8fN1e4+z7he7jpf9DY/Mu2kd1p1GrpvZrRaYzepTkFy0vH7ZLMqvyqxvJUmZC7fEnkNaU6E/p5xwlfWujN9JYvonwoZQIkVTbmdKLBTm+RVctEFsI/G5FMTyQdVVuDW9xWNlCM30Y4r5D2ZUoN71q+8PkHg9m0qbZTCt9IsnN5/CXu4UfVl+QUrtQ+BFjmsGNZyq2CkWAl/iNm9eb3ScmsEmF4QDs0sdO62syDeSevxvsF2U4Nuy/uNkD6OR8lEARu5kWagPPW5kJc502V+oAqGJlDs3aYKUy6lUmxQxlUBX71FRvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP1pEhRRpprp6QAYr88+X5ShMsH8fO6yNiXAXKE4frc=;
 b=Zz8hEqaQfwF9rVigbZp9cVWNJuYr+JnpBD56nRsA9VR6JdXtLGppUeAU7bQg6zHn+looi9QMM57J4iE1xdXQXcEyMe4/+OW+eFM0pNQczl5mIQSLzenq1QwQS/7lUONkIpN9NxxoRZoS5GMgatmZMQ2ivoHbbcCPCvMXmIDYRG0=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by CO1PR02MB8345.namprd02.prod.outlook.com (2603:10b6:303:160::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 15:34:17 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::87a:4f98:6252:dc66]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::87a:4f98:6252:dc66%3]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 15:34:15 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Michal Simek <michals@xilinx.com>, Sherry Sun <sherry.sun@nxp.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: RE: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver
Thread-Topic: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver
Thread-Index: AQHYOruPwCbohQGwHUqA66WG6I9jlKz3kBZg
Date:   Tue, 19 Apr 2022 15:34:15 +0000
Message-ID: <DM6PR02MB6635A97A9D7AC2A061188F84AAF29@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
 <ea5cc404-ab52-0df0-d3a7-f010e708a12d@xilinx.com>
In-Reply-To: <ea5cc404-ab52-0df0-d3a7-f010e708a12d@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9c05c0f-966b-4c3c-b627-08da221a0fa0
x-ms-traffictypediagnostic: CO1PR02MB8345:EE_
x-microsoft-antispam-prvs: <CO1PR02MB8345FB6B5D94A20ACC12889FAAF29@CO1PR02MB8345.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZScZf5lbqYU3m+flQadqG3wtNhTwndqtcSbIdycOGBoD9o/UHMsSyz1nkT7RtWjkBDcXijKs/cQpIVBlPyOX8/xHwNQtVjy8P6BI5MevRj/+MWYqMjSWtE3TzNWh+Pkul0npprfHRD6EpzvjC/B0bnHBA87zWKTTE9B0KjkLGZJaqOnJUsQTqI/FWrGUQnPYWezIFG8xhzxmpQZ4GICjJOsSNeLoteE8mgpDiX2n1jXjH9th2/9jP+n3Loo7IiwSLay7bvhBD6cO90RJSoUTJmi+eH2Cqp5O0gyX8dM/98wO6iBHoFDyXPY8Cbph3nrKoa4CeMvDMiJZW3R1ZgmlB9jmXGSFKFstvCug32iHV5CmFB9unZXAixOY2Eo3DIe8lnLSeS4fLiM3pageumezEbczmcVKNxX6ucNHWG2hskTyx3TFPJzqA9bzPcx4mydvh+BN9CYLRP4v5OUyriJqhhgNMSZRyQZ/Xx6vfPYUaIDfiifrk40rLTHWkm1yS59in021CctrzfdItiK4ca6MpfEAbmI/0DJzEIuRELEnc0HhYVePvf9nApcyVk39woSt4NX7TbJAn1YNNx/mSNTEFKu5OTOYvWkSgXgTUOU2OAe0j2JczChx1sp4Hzjs8jLNroO+oL33Jl43VXdXfH62SarYBu28Y0R8P3YdZgghboKxFnurqN5fQ/h/qqyJDT6irpIkAsTq0SSgh8W45rryRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(52536014)(66946007)(76116006)(64756008)(66476007)(4326008)(8676002)(66446008)(66556008)(316002)(110136005)(54906003)(122000001)(33656002)(38070700005)(86362001)(38100700002)(508600001)(83380400001)(186003)(9686003)(26005)(7696005)(6506007)(53546011)(55016003)(8936002)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFI0Q0taSE9aL2wwTTRPeHFpVkxIZTdlNEpzNGVkK1JqNnhab1RCVlRpdlBi?=
 =?utf-8?B?QzhiWENseGFPRm1nLzd0NEpSdVR2V3lhZ2NNZ2cvZjV0T25uZWtpOVA2dUVY?=
 =?utf-8?B?WVJ3WkNwcUt0VDQ0ZjlpYTl1ZkVQaGR6bVBoR2RTOFR6UkJxMGI1cjRjdWdB?=
 =?utf-8?B?NWVLZTZ1YzNhdVlYWTR6cnl4ckkxNmFDdll1SFBKTSt3K29XZ2hnYjJqUEFa?=
 =?utf-8?B?OGsrVWdva2xwc1lBQ0FCOVBMYW1kblloamU0eGx0RkVFR2VpT0dnbGNucjJz?=
 =?utf-8?B?eUFKSmVqb2FRQkRGbU9NWWg4WEVpR1hkSG4rK0gwd2htbXBtRER3R2s5NEFP?=
 =?utf-8?B?UGJES25URysraVZ1TTZCMjVuRVNJd2cxY1ZmazZCM2FsT3pJVmxvVVRMTysv?=
 =?utf-8?B?N2x4QzVwRVliYUV3OGw4TkVoQlU0S2FBV3JIYk1rQ05qeURyQklzNXcvS0tZ?=
 =?utf-8?B?Y3IrWnFhRWVDb2pvakNZZnh6Sm5vNWpNK0RFbzRxckY4akVyUkYwM28zYSta?=
 =?utf-8?B?T2d3VmZrUnpLcXYvam9XcEJWdGMra01HREVRcHFVZFJkeWVrRXY5aUVmQ21Y?=
 =?utf-8?B?S3lvSEpMekJCeUxIaFRRVklTZGk1RFBVTFNDWWMrRzZVbHF3TzNQMGJkdFIz?=
 =?utf-8?B?WWFFQ2FEREgyZEtkSlJKVGVrZHphRndLQkt2dVd5SHg3VTFFNjR2SGNGaU1m?=
 =?utf-8?B?MmhncEFhZ25iby9ZRTRGdmw4TE5ucVY1eUhUUXBwdEZVczRVaGdMK29UUGFE?=
 =?utf-8?B?a2xReGNIV3FZVUZpOVBmYlg1a3BMYndSaHRBU0NxQXlwRnVhU2crZnNpMlV0?=
 =?utf-8?B?QXdDbVBENmJHYzhxeUpzMllyWmk0ZGpoLzg2YVg3VnI3ckwvWm52UXJqQVhX?=
 =?utf-8?B?TG0yU1Rmd2hvRVQzdzNpTm02RE1HZ0Y5dXBMbmZTWEtDbzRaNkZ0SnhsZkhu?=
 =?utf-8?B?V0FsSkRSRmJyV2ZQaE5sbWJWcXJ2aXlNMmNxc0JkcXRaUnEvS2VMQWRCY2lE?=
 =?utf-8?B?dHVIQjBIdFRxY0FKc3BqaVlRUC9vUTY2NXhtODFCRVlIQmdUZWFKMGdFQmxJ?=
 =?utf-8?B?QVNieGczcGxzZVhVeFVaNTFiek1lTWUrWEJNcHFCYmx4UlR6M2hhZ3BwK3du?=
 =?utf-8?B?VWpMSnkrNHNwK2VsdXhKYjBSTmxBcitHalJ4QWNnaUZzbm5PbktlZVpjNmI4?=
 =?utf-8?B?YW1lZ3VjQVNlWlFWOExQeFR6dWlhamxXLzlhdXVuVi91YTlrbGQ3QzVrUmxN?=
 =?utf-8?B?dXVvS0s2M3NLMlN6bVZvOGxZcXF1U0NJeWZLWE9MQmZFMlpkeGx1d1p2amlh?=
 =?utf-8?B?YjFnZ3RuRFVCRis0d09iVER5YytaZUpMOFFPa3NQVzFjWFF5K3VSL1FLT054?=
 =?utf-8?B?blRkODg5WElqT1BtY282VkozMzB6Zys4K09Uek9zYkhMM1RXcC9LVlFESU15?=
 =?utf-8?B?dGJ2NitvZkNJWTB1NGk0RkQ4QWt2V2hNY0UzKzhKV3ZMdWZvR0pVQzRaU3Ni?=
 =?utf-8?B?dzJPQzJwOHpwR0NDQU1LbHd3cDIxakJkVTJ0VEJQQndRU2ZQUVF0L29IQXA2?=
 =?utf-8?B?K1VrZVdiaDFlKzZhbTQ4NEVRQ1JBLzdiZ1Q2VldDNUJOWkhySzhLYllIeTRz?=
 =?utf-8?B?bFAycFhVbUVPVlhiWmU2VkhkQXUvSkZicmJvYVNPeHRkckk1VFRhNUNjQW9j?=
 =?utf-8?B?cVZ0RjBqMHhmcHF4NXI0TDU1QUJUZkJGOVVMNmt5ckVCVE92SkdGU3l1OHdH?=
 =?utf-8?B?bE9pckhOVDl3akpOYU5naFRGaXM2SlNwanFoQzJjS0lhYzNRRU9qVnc0STdm?=
 =?utf-8?B?TDJpSHk2czRNYXF6d0tvR2w1WWgyZmxCc3ZsWnJSSDk4MitWT3RiTGdlNU5q?=
 =?utf-8?B?YVdjNy82TXQwRUJDQTJraXZndHZ1Ylorb0wxK1pkYlJkNmxhWHRjVWFOVVJl?=
 =?utf-8?B?Uk9wTmwyY1lZRk93eFFwalpxbnVtU2t6UUVFQjBhQUdEU2ErR1VyZkl3NTNp?=
 =?utf-8?B?N3h3WnI0THVIcWVNaFZkaFplVktzSjRGODExdW1xOE1va3pTMUFrUk9PTDJm?=
 =?utf-8?B?dmJPb0pxZ0hrcURpME94YmxEUnlRcDhwVkdtazFwa0htazZOQVpocjZ6bytt?=
 =?utf-8?B?eVF6RFIydkZGNzFhRFlxdmZVRWdwNndKUUJvK3JnbHRZVmNaeThicXZBT1B2?=
 =?utf-8?B?ZmRSL2FBV3R0Nk5qcjFXOTNmaG16SGxUYmZTRDBnUU9JV3I5bkV0MFJkRDFx?=
 =?utf-8?B?aTlGRnN3SGhIZUU1cXU5QVFhSU12a0pFaEM4YzJlMHAvcDQ1eWhBOWNQdFdj?=
 =?utf-8?B?Q3l1bzJPaHhQZ2c2SW9jOHVNdk8wMmROSUsvVU9iYjk1RnNGcnd3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c05c0f-966b-4c3c-b627-08da221a0fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 15:34:15.1000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsKPzQizJVw9pL8eDAC2rb9xAE/EdgpIz558VmiV4n2Qd6DX1PjkZkEqjYSJZb8N0YysNX2gE14+OkaOLpeouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8345
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIFNpbWVrIDxt
aWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxOCwgMjAyMiA1
OjAwIFBNDQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+OyBicEBhbGllbjgu
ZGU7DQo+IG1jaGVoYWJAa2VybmVsLm9yZzsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5j
b20+Ow0KPiB0b255Lmx1Y2tAaW50ZWwuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOyBycmljQGtl
cm5lbC5vcmc7DQo+IFNodWJocmFqeW90aSBEYXR0YSA8c2h1YmhyYWpAeGlsaW54LmNvbT4NCj4g
Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1pbXhA
bnhwLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gZml4IHNvbWUgYnVncyBpbiBWMy5Y
IFN5bm9wc3lzIEVEQUMgRERSIGRyaXZlcg0KPiANCj4gK1NodWJocmFqeW90aS4NCj4gDQo+IE9u
IDMvMTgvMjIgMTI6MTcsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gVGhlIHR3byBwYXRjaGVzIGZp
eCBzb21lIGlzc3VlcyBmb3IgVjMuWCBTeW5vcHN5cyBFREFDIEREUiBpbg0KPiBzeW5vcHN5c19l
ZGFjLmMuDQo+ID4gRm9yIHRoZSBkZXRhaWxzLCBwbGVhc2UgY2hlY2sgdGhlIHBhdGNoIGNvbW1p
dCBsb2cuIFRoaXMgaGFzIGJlZW4NCj4gPiB2ZXJpZmllZCBvbiBpLk1YOE1QIHBsYXRmb3JtLg0K
PiA+DQpUaGUgY2hhbmdlcyBsb29rIGdvb2QgdG8gbWUgLg0KDQpSZXZpZXdlZC1ieTogU2h1Ymhy
YWp5b3RpIERhdHRhIDxTaHViaHJhanlvdGkuZGF0dGFAeGlsaW54LmNvbT4NCg0KPiA+IFNoZXJy
eSBTdW4gKDIpOg0KPiA+ICAgIEVEQUM6IHN5bm9wc3lzOiBBZGQgZGlzYWJsZV9pbnRyIHN1cHBv
cnQgZm9yIFYzLlggU3lub3BzeXMgRURBQyBERFINCj4gPiAgICBFREFDOiBzeW5vcHN5czogcmUt
ZW5hYmxlIHRoZSBpbnRlcnJ1cHRzIGluIGludHJfaGFuZGxlciBmb3IgVjMuWA0KPiA+ICAgICAg
U3lub3BzeXMgRURBQyBERFINCj4gPg0KPiA+ICAgZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMu
YyB8IDExICsrKysrKysrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo=
