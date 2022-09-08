Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A795B141D
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 07:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIHFkM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 01:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIHFkL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 01:40:11 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CDB49B76;
        Wed,  7 Sep 2022 22:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1yoPFzAmRNrz5tuaffaqJKMYI+a3RROZKJZ2Pjzv5K+B0hr0RKrmgZZK3m7LvLX1HPItPjlQ6O0m4aCd4UzG0hxO9cqbCTdEbVW2MIDCEnwVwwCUhV1Ev6/kWrFcAg9hF7X8MvigG2hwXOSnsiVXeAGZCJGasYF3YRVh0PKwwjEY/a6ouM8KI9k1kVe8e3mH8ID43b6iRUOyIGB7vECU8l23Nb0xj1p8VlMJcTe8Lt15pu/xLQD4piPqV3ArqIIC7U18mLNv3ZK+JvO6c3CABH35RXPx0fHTFUqy4YeRBFzkn41z9CEgdmsQDEAmKS6OGXCKU2BvR9Ma08DU08Jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbTr/JdxUVN4PgQC3a3ogJ9RVWxr/GLqRUqCSG+rIEM=;
 b=cToGWVGVT04cTc0nbxzrlUHJ5Wwc0e3NUWSHcDwOY85Hd9trJgn2C6TTNvciZ4OH8XeYRKQLw5rmff02y+r+QH1lIH+dWIkLzC1V/9SBCM86k5iBPd2XapkKPiL7brOzEVCxCKw7jfXFuJcPaX73JjjheqPOC9lv3A41YmcNTueCYhiMgMUFfadmyleRGbbtjZZb4KSqINKuaukCU67C42qP11rncqYLyeFQgZdluqTY2dQlfEjEAV5bi/An1W5hBLQ73x43HSF7j5aAc2sehfEXhUVBMFr5X3eLeMz2rhjGwDPOWStfgB8TAyu1ZXo6i+3//dAbhH+85FZuswFUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbTr/JdxUVN4PgQC3a3ogJ9RVWxr/GLqRUqCSG+rIEM=;
 b=CDlZoRM7l4FgLDHNC1qbuzbennDw4hHbY/AHtZwZ19wxJdLzVngsJxLCHuxyXKMsTI1E+I+tMIdeskzlbz2+02G6GTDTw/N5WZg4g9tySQpDaVBwSgith3b+KBr9NsE4LiKU35qeOTWqRlq8zqTvzH1onkJR6HCvKhwYzydY3Bw=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 05:39:57 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231%4]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 05:39:57 +0000
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
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Subject: RE: [PATCH v4 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Thread-Topic: [PATCH v4 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Thread-Index: AQHYwqtoeX2MhABwF0S4ucamabz+ba3T/zcAgAEApQA=
Date:   Thu, 8 Sep 2022 05:39:56 +0000
Message-ID: <BY5PR12MB4258C4746631BBD6A7B388D6DB409@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220907111531.703-1-sai.krishna.potthuri@amd.com>
 <20220907111531.703-3-sai.krishna.potthuri@amd.com>
 <YxikJCguJWunfh6x@nazgul.tnic>
In-Reply-To: <YxikJCguJWunfh6x@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bdffe4f-a029-427b-a0df-08da915c90a3
x-ms-traffictypediagnostic: BY5PR12MB4950:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KfU3Evimuqzc0fQvPzBwZ8Fhiyjn8rvIJ3E7WDPFjD3pWbITvr5ZIzZUKylCLMdQ5Kkez5AfF1PYBkgssH+kjmb1tCbErUGL+/kBtytyZhRXEFsvcAj8+Auqu7SvcmLidDPBwhrMWr+SVNI5s3PV1pk5U2PJ57DMMqT60XrkcGRqsuuEemkxsThM9Yak4bp9AWy2ffue/cJDPb1k6tr3W5hfQtjeEfdkAyF4upYw+CDkMlM17FQkPDv35VNfbzv74iJzDIt+OJYLxcY7i1OX/O9KxHP71Sg0eGjGrn0bE3QqegesNF+TV/pdTbiVTS/g7yX2yqg2FyHi9Gwxy+M3Bk8IiEmZeiNCKd8DTxegAp4OTWGePjd+6/Mi3O61TlY507+agx6VriTm7nFTQmReBMhMQPffQi5CzvkmoNbZUxPH6tU/wzuLlAp/jnoRs/57LS0d20uSviFRDHOvQuEuWz10uWYReaIPo5rzPco1brctUtABFCIgyegpMTUzeHhrdVMxPO5hgsTpHUU9QWUGYtWSnDbBIcS5tiS0sK3RxR88MNsf8I6uE7IY4qP0KRaUIhOK7NeO9T4a0i8z6dGArTfaRqTJ3XltPJvpQY2j1JFdcliaxYR4zoo5H9UJh6uRtOULPO41rV3jHLJnUn4FEDt2u5DBwgY9G5v4ZcJQAuVkO/ZybHrix7vwIhIBzjg5Uhm1Tb6JMcYD4a4lJNLfTPHsX/hppGiGvcHJe3KcL1yK+ebMEpYEVQ8rrwwRyqyG7c2U+7zoXYtaeNgRcpkUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(86362001)(316002)(54906003)(6916009)(38070700005)(9686003)(26005)(7696005)(41300700001)(6506007)(53546011)(71200400001)(186003)(478600001)(2906002)(7416002)(5660300002)(8936002)(122000001)(66476007)(55016003)(33656002)(64756008)(38100700002)(66556008)(4326008)(8676002)(66946007)(66446008)(83380400001)(52536014)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGxSTE43MTRINVlSbUpWT0NrU1hmRlg4VzU1RUV4dGtndHVPcE9pTjMzUmt0?=
 =?utf-8?B?bEZTWWhTNEtqN2tqZklkRTRVR0ZJbVVSZlB2OFcxMGh4SCtIYmdkZ1lqaWUw?=
 =?utf-8?B?TGIxNVNtQ3JyR2tuNmc1KzhwNWVjaTJON0xjYU9ITnVnZTR2WnIxWmM1ZVRS?=
 =?utf-8?B?MXhVeE9Yd2lzeTlvc2dFZ1k3TmpXQ1UvQmtyZjlpVCtFTTFDeXdJUUxHaWNB?=
 =?utf-8?B?K1NPem8xT2J1SHg1WmJHSW1xalF1S1FMM3BaMHk2c083emJ5ZXlkekJQVXZU?=
 =?utf-8?B?WFR4MWFqRmU4ekJza0E0K1R1bFdRSkVQaGhNUlNOU0FhcmRqQkkvUkJ6Qko5?=
 =?utf-8?B?SUhHbG4vaHFsMjJVdWVXNVBpanNmY3VDa3U3a0MrTjJYSjVmY0kvZHNZU1NY?=
 =?utf-8?B?NUpRRm5WRDFkM3hNc1RDdk5lOTI4RlFxam5CMm82VjVxWTRxbjNRa0syR2lE?=
 =?utf-8?B?WlN5YTV2ZU9QaGt6R1pmYUVLcHRLazdqakRWNmVHNTRLSWxtT1dWbGpwNnJy?=
 =?utf-8?B?Tkg5a3ZockoyamJIODhJVW1ZYnBVQWhHeE9Id2tiR3ZjMGVrNzk4RDZ1cWhm?=
 =?utf-8?B?V1NLMHFqbGE3ei9MY21ZbUlrWXVEVjVlR2p0ZExjTVBPbHYrS1BaOXJKMWxt?=
 =?utf-8?B?RTdJcGFsQ1NPVjRhQVdaNWttdUIweE1vVk5nVkxTK3ZRNFlNS3hSeVVaYTVl?=
 =?utf-8?B?K3JPdFRGL085VDhHSnZkT0t0dkNqY0gxVStWR2dZVTNDWmdDQTJDdzZCTFo2?=
 =?utf-8?B?T0lOUEU1QWhxamNDbkt1QlRiYmhKQ2IvVUtJVGk3RFFNN0lpL1NYLzIrd1lO?=
 =?utf-8?B?Z0E2VWt2cHJrV1I4MXZiUTh0VXlnbmJ6VXVYL3N4dCttdytGb0gxdHlvVHl3?=
 =?utf-8?B?VHFyeHdnVHh0MFlOSFhGcW9GdW1MSUF2TDR6TXZOZ2daRWJ5ZWhHdDhoaXB6?=
 =?utf-8?B?Y04vYVdHNHB0eVhzU29BeDNBL00zTDRjM25FUGx4bzR6T1VjRFJ2bG5BWElu?=
 =?utf-8?B?T1RHazAvVUVGOGk3cC8yM1Z1RzFCTmlQa1NCNisyZlYrcUVHdHNheUVXM3Rl?=
 =?utf-8?B?OGZsRGplQ2RMSGFjUTh4RnFIL20zM0FDempQbWF3b1FaS090TmRVbHNUblN3?=
 =?utf-8?B?cnBUcmRmbHRBTDdmOTZyc0lWQW1zRHI4Tkk2NlZYRHdqN1ZaeUtBUEdhdFAw?=
 =?utf-8?B?ZU5UODM3RU9BR0IyWnRjKyt0Uy92RjlWcXg3SUtyaEhnbFRoeXZ2WXZQL1RT?=
 =?utf-8?B?b3YzVnNOVFJxVFdQN255b0lTMnZZc1JNVEZVaVVnS01hQWk4NHVJbEJGcGcx?=
 =?utf-8?B?U3RLQWg1NzNFNEFlU1gvZFJMTFJRcEdQVW95cXNIcUx6R1Q3TjB3Vk9pdmln?=
 =?utf-8?B?NGREbDFzTENZSEdLZGppaUgvN3RQeDFmZC9ZbTJnRVNxSXFyOVhlYVJabzVV?=
 =?utf-8?B?U2lWS2l6b1lLUTk0NTZpU2J3YzVzbS9JZUMxYkFONUtyUFo1TUNndW5BUVVE?=
 =?utf-8?B?NUwwSXNjVW9zOTMxb29aYnNuN3dBc3ROSDJ1elMwQjZMaEdCWGNlZ0xtY2Jx?=
 =?utf-8?B?VjBhSDFWTmZLMndXK0RzYTBmSjNoUVpHVlpaME9xbkFxNTdrMVhnSVEySTU4?=
 =?utf-8?B?eTVMc1dpM2dOT291RzZDRzV2RnphNUVIeExObnZQeWIySGJrb0tUUmhmUXRN?=
 =?utf-8?B?NEMvUU9OV1FNaHZsZ0V6QnVvWHJhQ1FOMXJUOVBCRDF6Z05QNzdwd0FUdmkz?=
 =?utf-8?B?V2xMcWdPSHdRWEIybnNNUk1XTEs5bGduYTVpVjIwaUgwSVZMVGI5VHE5Ym1S?=
 =?utf-8?B?MjNvYy9JMVVqOFZVSVFwbjhRS0dDcDRnQ0FTQTJjcGpkU1NQUHAwc0crTWow?=
 =?utf-8?B?MlBKRHNRZkVwb013R2VIQWxlZThJaVZOYlV0MHlwV3d4WUxmSWhxcnVMUWFH?=
 =?utf-8?B?eUZVU0NXeXFVUTE1WDdxN1dEU24yVUt3bDhpdHlJK1lKMnlTWWVlYk5KaGFF?=
 =?utf-8?B?Z3hqYjRRZ1dOZGhmNUlvMDZGanJCSk91Mk1PTE5DSjBjMXNsQ2E5dW5GSURH?=
 =?utf-8?B?QkZpUGh6WDBuUGFrSGdLTSs0eEt2Tk10Q1dQd3RPakNaTnd2RVFGaURGVDQ3?=
 =?utf-8?Q?a+Is=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdffe4f-a029-427b-a0df-08da915c90a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 05:39:57.5696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0CEaDz6oXwTD0gBDAo3mu5NhgxMQnzPhDlJids/Q2cOD/XN9El9ZO7+ehYA7z92tey84PdxatTcnUSrS5ONNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4950
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNs
YXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDcs
IDIwMjIgNzozMSBQTQ0KPiBUbzogUG90dGh1cmksIFNhaSBLcmlzaG5hIDxzYWkua3Jpc2huYS5w
b3R0aHVyaUBhbWQuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47
IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9y
Zz47IE1pY2hhbCBTaW1law0KPiA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+OyBNYXVybyBDYXJ2
YWxobyBDaGVoYWINCj4gPG1jaGVoYWJAa2VybmVsLm9yZz47IFRvbnkgTHVjayA8dG9ueS5sdWNr
QGludGVsLmNvbT47IEphbWVzIE1vcnNlDQo+IDxqYW1lcy5tb3JzZUBhcm0uY29tPjsgUm9iZXJ0
IFJpY2h0ZXIgPHJyaWNAa2VybmVsLm9yZz47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsNCj4gc2Fpa3Jpc2hu
YTEyNDY4QGdtYWlsLmNvbTsgZ2l0IChBTUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBEYXR0YSwN
Cj4gU2h1YmhyYWp5b3RpIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NCAyLzJdIGVkYWM6IHp5bnFtcF9vY206IEFkZCBFREFDIHN1cHBvcnQgZm9y
DQo+IFp5bnFNUCBPQ00NCj4gDQo+IE9uIFdlZCwgU2VwIDA3LCAyMDIyIGF0IDA0OjQ1OjMxUE0g
KzA1MzAsIFNhaSBLcmlzaG5hIFBvdHRodXJpIHdyb3RlOg0KPiA+IEFkZCBFREFDIHN1cHBvcnQg
Zm9yIFhpbGlueCBaeW5xTVAgT0NNIENvbnRyb2xsZXIsIHRoaXMgZHJpdmVyIHJlcG9ydHMNCj4g
PiBDRSBhbmQgVUUgZXJyb3JzIGJhc2VkIG9uIHRoZSBpbnRlcnJ1cHRzLCBhbmQgYWxzbyBjcmVh
dGVzIHVlL2NlIHN5c2ZzDQo+ID4gZW50cmllcyBmb3IgZXJyb3IgaW5qZWN0aW9uLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU2FpIEtyaXNobmEgUG90dGh1cmkgPHNhaS5rcmlzaG5hLnBvdHRo
dXJpQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2h1YmhyYWp5b3RpIERhdHRhIDxzaHVi
aHJhanlvdGkuZGF0dGFAYW1kLmNvbT4NCj4gDQo+IEkgdGhpbmsgeW91IGZvbGtzIG5lZWQgdG8g
YnJ1c2ggdXAgb24NCj4gDQo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNo
ZXMucnN0DQo+IA0KPiBpbiBvcmRlciB0byBidWlsZCB5b3VyIFNPQiBjaGFpbiBwcm9wZXJseS4N
CkdvdCBpdCwgaSB3aWxsIGFkZCAiQ28tZGV2ZWxvcGVkLWJ5IiB0YWcgYW5kIHNlbmQgdjUuDQoN
Cj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9LY29uZmlnIGIvZHJpdmVycy9lZGFj
L0tjb25maWcgaW5kZXgNCj4gPiA1OGFiNjM2NDJlNzIuLjA4YWRlZGZkNDJiNSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2VkYWMvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvZWRhYy9LY29u
ZmlnDQo+ID4gQEAgLTUzOSw0ICs1MzksMTMgQEAgY29uZmlnIEVEQUNfRE1DNTIwDQo+ID4gIAkg
IFN1cHBvcnQgZm9yIGVycm9yIGRldGVjdGlvbiBhbmQgY29ycmVjdGlvbiBvbiB0aGUNCj4gPiAg
CSAgU29DcyB3aXRoIEFSTSBETUMtNTIwIERSQU0gY29udHJvbGxlci4NCj4gPg0KPiA+ICtjb25m
aWcgRURBQ19aWU5RTVBfT0NNDQo+ID4gKwl0cmlzdGF0ZSAiWGlsaW54IFp5bnFNUCBPQ00gQ29u
dHJvbGxlciINCj4gPiArCWRlcGVuZHMgb24gQVJDSF9aWU5RTVAgfHwgQ09NUElMRV9URVNUDQo+
IA0KPiBXZSBhbHJlYWR5IGhhdmUgYW4gRURBQyBkcml2ZXIgd2hpY2ggZGVwZW5kcyBvbiBBUkNI
X1pZTlFNUCAtIHRoZQ0KPiBTeW5vcHN5cyBvbmUuIENhbiB0aGlzIG9uZSBiZSBtYWRlIHBhcnQg
b2YgaXQ/DQpTeW5vcHN5cyBFREFDIGRyaXZlciBpcyB0YXJnZXRlZCBmb3IgRERSIE1lbW9yeSBD
b250cm9sbGVyIGFuZCB0aGlzIGRyaXZlcg0KaXMgZm9yIE9DTSAoT24gQ2hpcCBNZW1vcnkpIENv
bnRyb2xsZXIsIGJvdGggYXJlIGRpZmZlcmVudCBoYXJkd2FyZSBjb250cm9sbGVycy4NCg0KUmVn
YXJkcw0KU2FpIEtyaXNobmENCg==
