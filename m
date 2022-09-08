Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6685B2896
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 23:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIHVcs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 17:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIHVcr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 17:32:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3536DA6AFA;
        Thu,  8 Sep 2022 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662672766; x=1694208766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=te+JI2E10TIN21PVelvVRjaKvRaO9DGELOw16imIjHg=;
  b=hE8fpEni6xEjVGAkE3C7hgxzP95OM9C22GkTmR8frCrB1JsLu9EQginv
   CP5I8ik9cmJ63IFxBHr5mZ/CwtK7lOoS9exJD+o7xSc6qCtyLDcnYy3Fu
   lfwZt1+uYapRJLkYag38qiKOOavoQ1DVvwozsneD8K2Jk78PiEaX4P1SJ
   xE7T6zj4UoQZxMQgeZAhhNnkAdF9B26fupzMMprd/YZ+CIUdYACLFyrew
   ZxNqViswxxNUK4NNAk25P/pRlq6lQW+uotPa0uh13Gt2+kEe42Px+ElbS
   nSZ2BrXF9y7z4QxuBucajPWQAZlRYyuDRdT0657Qug7Of+csrZP4vI6IV
   A==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179762270"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 14:32:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 14:32:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 14:32:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6mMRHlX2sn0SSHE93ICDNnXrXtIPWnvjMcSve/uFqRVOIGTDNeO8/E+XTFhYIXX/QMnRdoLGtWtdzlJX070BOuan632daFIzDRmPhRuGp4QY05nh86mEARL0oYt2ThVQM9B/LEW+Hv4ADeYvlZ5CWzjIJAUhAXhbIXd+WeRsrdb56aeFbLrixVZbNrNIq+dSQ6sV0T2VKK+dJBG0a05LjXr3DlsnCbcs943dprZWnoIaw8NBJNT25aW5UY8g8JGWA8dJbO1YV+Y7c2gdebkeLHB0m6qIl+2+LjQhUnaYZvmow6qOrpmMJyWsEZ+dAbTOL+9PHtyIe2w7T5GS2qbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te+JI2E10TIN21PVelvVRjaKvRaO9DGELOw16imIjHg=;
 b=ArfsyRMs3IKroq/UsqzoyxqyaW9lXjt8EnDyA5OqqwlJ8TtIuqFHAoZrm9xXlG9AAv33kQUEj2dqt49079xpDKO3nvuyiFEYZYQ2bdB6zaZXPn+MZ5bChYKxQNWVF7DjU1IfbpZoN72K2zmmhl4S7V/AzSkZpe6g2dvsLFxDITrkdvnimBiFzLnuVzoFkatttDVGBEu8yb7w2l+5NIqkP9nbmsm39KhNmCTfMFzACKQuYIS5RiAOE+Xa/fzOfFvjuQ0EH6YjzTHEpBDe1aMw1z3rqZH7cyv8T1twS2xE97nvXcyDi7nPlRFQGJt07oOz65xz1SzMHXgIUr4lc+4uVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te+JI2E10TIN21PVelvVRjaKvRaO9DGELOw16imIjHg=;
 b=On1T62Webh3OC6+eN09xTjpD5gNix5YzOSDMvxh1JzB3yNsEcH/XtkZX6JN1+CEmmi74Bwre9M2kZJCbFAPCzXI0c94rPlfXjyaW9OfTTKf2518oMaLyHKGrTs2vtk65ko5d/tsbTl2fcTfEag5NKCv/hZW1mt6CEGZkZ1tEoKw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 8 Sep
 2022 21:32:32 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 21:32:31 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>, <zong.li@sifive.com>
CC:     <linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <greentime.hu@sifive.com>,
        <robh+dt@kernel.org>, <linux-edac@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <ben.dooks@sifive.com>,
        <linux-kernel@vger.kernel.org>, <aou@eecs.berkeley.edu>,
        <bp@alien8.de>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: sifive-ccache: change Sifive L2 cache
 to Composable cache
Thread-Topic: [PATCH v2 1/6] dt-bindings: sifive-ccache: change Sifive L2
 cache to Composable cache
Thread-Index: AQHYwQH9JkERmMJcy0a/nxtQVT6p/q3WD8cAgAADNYA=
Date:   Thu, 8 Sep 2022 21:32:31 +0000
Message-ID: <109a49da-6c7f-70e8-6da7-647bd03795db@microchip.com>
References: <20220905083125.29426-1-zong.li@sifive.com>
 <20220905083125.29426-2-zong.li@sifive.com>
 <20220908212102.GA3361862-robh@kernel.org>
In-Reply-To: <20220908212102.GA3361862-robh@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|CY5PR11MB6319:EE_
x-ms-office365-filtering-correlation-id: c7943ca3-bd6b-4def-d890-08da91e1a322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JdEYhIYg1ZEWerpVpOwcBlzkfmQ4WqqDaRyVcL6xHo9HQPV3s83d4f6y+/Co8Qr/WPfF/TDl002jm29HUYBSFP61CDc71KRKirtEXdYiZFV122Prha76fcHkpo15w0q03Dw1Hz3ZMCEwaF8c91c2uRvJNjSH4/B0xSNHQuWcBDTW80riQqpqkFT4fz9pCgfBY5lKtzVzsQpzYSK1q3SuxDHO0LUdGCPJw0l6XOdAxljrzPZL/8DquFcEls+SiHhMWaMMlNNZtX9GQXUn+QLPDIdsQhAjTdca/cS0cPpzjGlWPlaTrzzYSnHKjK2aBXm8bQVBXcGHlzC/3OI0M0/95TwyBUZ4uVn+9AEq/4OIGJquBNqEJtyaDCDrmQcH5bBt9kMW+vEsj2gRmL72izkHGQMlrZud/ZJMNSKjhKftCTsEEo0f+9UPJNf1reE+hQXOftWPokpI2QlEWSQc+jK7JY+PGMhiUc2g7y9N4NvIbkTjV+fGKKgMbjkZ+aLGxEUnTIEW/XHyXMwcaFpVDWb70yYfDvGPNYbNUBKVuUEK3X3d/8LyElWIo/Nut0CvYLzG/qECv0081JNS0iM+AbI20gJpQMgHUS/xTBUx0hnWYtYUq9Rhaowo6nG0LLO15sVz3VWSXlmKcRTE7SHqBOXKnqCTauq0x48AMbkuUoLbtvkf7NZY48AlRGLQJ3GdFSxV0+ioKe/6GJpculBWDL8/W1bgIElkEuo+y44ERJElVfv/SwIwz/gAs5t5Th1zF2iveIrniNTGfkXsJnHGoB1jYqxRFyX8hHNavZmShalioHVuRnWmqzpPW7T7Z96XR1jGIG8+J3/0CtFtOHvBAJV1V9K0gIIIxT3BhBNv1KtPvGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(376002)(136003)(366004)(4744005)(71200400001)(110136005)(26005)(41300700001)(478600001)(966005)(38100700002)(7416002)(6512007)(36756003)(6486002)(8936002)(54906003)(31686004)(38070700005)(5660300002)(2616005)(91956017)(53546011)(66946007)(83380400001)(66556008)(8676002)(31696002)(6506007)(316002)(2906002)(86362001)(66476007)(122000001)(186003)(66446008)(4326008)(76116006)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUkvaXpYRFI5S1FPdU55dUtuLzAzUFNVa2pKS3lVWjBndWtNbUtMb1FaTm5Q?=
 =?utf-8?B?MEZHMmRPaFkvVUpkZEtPSXlBbkdkTFFSQmtKUThUTE42eUJFNXBrRTlTODl5?=
 =?utf-8?B?c0xvS0VRQUdHbTdPN2tNYkpxVnhiL3BXUUIrNm1zdHZSdFI2QVNreFRaaE5Q?=
 =?utf-8?B?SFdUeHFpQWR0dEkzbUh3S1BNeEE2STVvY1Jxbmx5TTdBWVNUbGlQKzh1RHY1?=
 =?utf-8?B?KzZBS1BqTVNJWGR6M2JHcXEvQ1UwSGEvWkpsNzBjOFJPWXNxNFh6bE5BNzUx?=
 =?utf-8?B?VGV4S2c3SHd4cGJ4Z1A0cHFqK1lsZUtTSzFOaFRsTm95MDNHT1EvY0lLU2Iy?=
 =?utf-8?B?OFdkdVgzWDg2UTNGcHVBWHBEVHppL09UM2h4NWkxbzdXOTY2dEUxQnIyL1hH?=
 =?utf-8?B?YUlMY2dIcHNheE1yN3JVeXVNWjRIREEwREp2UFl4RVI1L3V5M2NnYnRmc0dk?=
 =?utf-8?B?U250Q3Q5S0ZLcVNNaGgrZUQzZ09jZXAwbjFPcUhkeHZrQ1JQVzFmOUV5cTRG?=
 =?utf-8?B?RUNaUVpYRU1nOU5iMnVVYW0rak9mR0JtdCt6bHgyaGJBMFZnNVVMeWNOcUF2?=
 =?utf-8?B?TmtzZmovZmFTM3o4MVQxZ1hyLzRJYmFsc3FBZ3JFYzkxSVIxeXVaYWFkejlM?=
 =?utf-8?B?cExtTG9RUWJXRVJUZld0ZmpZcXVTNDhuVG5ENWcvQTR5YlppNzNoY2NyT2JV?=
 =?utf-8?B?MitkN3I3U0JBSjVab1UrcnE5cjJEQXp4QWJoSEc3WXIyK2N4ZFQyeFZ0ME1X?=
 =?utf-8?B?WTBCU3A1RkxPTDBjb2hnOHFYT2FXN1h4SkdUalBhNE1ucjMxdi9od2E2azZv?=
 =?utf-8?B?UVR6LzFHeWF1VjJoNDBjWDJoOVNVV09pbzQwV2Vjem9lRlFURWRsbFZuVEhK?=
 =?utf-8?B?ZDRmT0M2SURkYXh2T3RSR0h4d2VESVozWHlwY0lMVzd3dVpnTllCNWJNTEV3?=
 =?utf-8?B?REZmSElsdExMekhNcmFNcSt5Y0NJSENia0kwcExsblR6Mnc3VjVsdzJZZjk0?=
 =?utf-8?B?RnNUeThJS3lBb1VNQzhBTmY5YSs1ci81ZjNLQXRaczdnekcvM0ZYcmZKUyt3?=
 =?utf-8?B?YlV3bGhzaCsxdU1YSHJ1eHEzMGV6VjNTa3ZTWi9DN0hxQWp4RDFodmxCU0lD?=
 =?utf-8?B?Rng2a2pkc0dEbWRqL3JwWjVvVEt4SHRKVXQvd0hodEFSVFRqVWJZMjZXbEUy?=
 =?utf-8?B?QXVYMnFqU3VTakk2K1U0WVI1TTF0bTJzUmU1WjRicWV5Y2VNSzBaK3lCSGpx?=
 =?utf-8?B?ODd3Wml4RjRPcW1id0J6RFZGeTdUYVAvc3FYVFI0MmpGd1dmbHpCZjRXSFhB?=
 =?utf-8?B?V3RlTXhKa1g4a1J1RStIU1ZWcTlTamVpTENQWWpnN1FFOURwMWJWSG1vU3lj?=
 =?utf-8?B?dWJtZU94eFU0UFAyV2gvNUtvZzBsN2ZjajVxZ2RYbjFKdCtMNHhMQVJSSDdF?=
 =?utf-8?B?U2FDd2o0VDhzNGJsaGN3b0FvckVYdlhpUmY2Q0NiV1pMVnFBT0dmajVEQWMz?=
 =?utf-8?B?OWlHWmRNSkdoazlydkNXL042RHJUWUc3OXEyYlo1cGVLQU80aURlaURzZEZH?=
 =?utf-8?B?TWFHTW8zcmlaTmJKc0lvM0cwYzBjWGxsRnROTFhVek44NXRYaXhOc2k3dVJO?=
 =?utf-8?B?T1lYWXBDVFdWaHlNRm5kODVjaUdRMjhRcGF5Ukh5cVhsSE5QM1VjUlhuUG5P?=
 =?utf-8?B?d2YrTThtd3MxODhsdmg3N1ZmeC9HSVMrSnhZd1ZGL2NLaC9TK2FYbnFuWW41?=
 =?utf-8?B?cHZvMitrek4zZUc2dGc2VzRVWDBhQjVGSCtZL2I5Y1U1enVWNWp1d2pHaVNk?=
 =?utf-8?B?SkZXazNrWXZqaTNIc3UvYUFKdkVUL1JsWlBLZjlSaFU0cyt4SSthRzFpQkRI?=
 =?utf-8?B?RldObk9GRDU3L1FOZVEzVXlYY05Ld2FSWXNXalJDZEVydDJqMGNKek4rb3V3?=
 =?utf-8?B?VWtUcVhxRHJKZ2dGRGRyakltc0RGUUR2NFphZVVhSy92anpIYU1RUGlEeXlw?=
 =?utf-8?B?Z3I1QmhyTWtpVzRLR0xhY01TZlcrbkd4bExFQjNhVzB3aDZxL3RpbEdvUDJW?=
 =?utf-8?B?V2RZalVhbHZWbm5JVEVlSmdjaldQWVNpZzUySmc5KzNqc1pMSzlweFlTcy90?=
 =?utf-8?B?ODlDbm9iQUtXSzY5RVNWbFJqTDkxVE1OYTlCajBkelNHOUxyTEhIZ3l0ZEhs?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <265443EC6BE6304BB1CC874215D308E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7943ca3-bd6b-4def-d890-08da91e1a322
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 21:32:31.6829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HEH5YSn+n0tQ3mbvwU1AMVCqkb2udAMsOC1ywN8n24DNKoBf0WGBdG2e7+W/8z7D0cNrTuLBz5/BCKi3gvdOf2eEkRmG/R7KFwiJNgZOkkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMDgvMDkvMjAyMiAyMjoyMSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCAwNSBTZXAgMjAyMiAwODozMToyMCAr
MDAwMCwgWm9uZyBMaSB3cm90ZToNCj4+IFNpbmNlIGNvbXBvc2FibGUgY2FjaGUgbWF5IGJlIEwz
IGNhY2hlIGlmIHByaXZhdGUgTDIgY2FjaGUgZXhpc3RzLCB3ZQ0KPj4gc2hvdWxkIHVzZSBpdHMg
b3JpZ2luYWwgbmFtZSBDb21wb3NhYmxlIGNhY2hlIHRvIHByZXZlbnQgY29uZnVzaW9uLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFpvbmcgTGkgPHpvbmcubGlAc2lmaXZlLmNvbT4NCj4+IFN1Z2dl
c3RlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IFN1
Z2dlc3RlZC1ieTogQmVuIERvb2tzIDxiZW4uZG9va3NAc2lmaXZlLmNvbT4NCj4+IC0tLQ0KPj4g
IC4uLmZpdmUtbDItY2FjaGUueWFtbCA9PiBzaWZpdmUsY2NhY2hlMC55YW1sfSB8IDI4ICsrKysr
KysrKysrKysrKy0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4+ICByZW5hbWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Jpc2N2L3tzaWZpdmUtbDItY2FjaGUueWFtbCA9PiBzaWZpdmUsY2NhY2hlMC55YW1sfSAoODMl
KQ0KPj4NCj4gDQo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
DQpGV0lXIHRoaXMgd2FzIHJlc3B1biB0b2RheToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXJpc2N2LzIwMjIwOTA4MTQ0NDI0LjQyMzItMS16b25nLmxpQHNpZml2ZS5jb20vDQoNCkNv
bnRlbnQgb2YgdGhpcyBwYXRjaCBzaG91bGQgYmUgbm8gZGlmZmVyZW50Lg0K
