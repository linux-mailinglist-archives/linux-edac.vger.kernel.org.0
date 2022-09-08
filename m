Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E95B25C0
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIHSaN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 14:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiIHSaL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 14:30:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4451A13;
        Thu,  8 Sep 2022 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662661809; x=1694197809;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=IU1E73PySiuNerKQY4qBD9q6n2T50CGNHPOKh6Evcdw=;
  b=pgF6Q4lliJFhVL7AFF9LA8QfhYEN2zXprqg3LjeCVv9XWfmwHufyZQ8y
   bTwwNM749N0fD/kqx1vZBhQkfBG0Dwj5xX1tOf1u71f+ZvP8B63gRRFyI
   RC5OKD0/xzYrVTEUQljx4J6+v3uxEACRr0+tXnV7d17yk5pNJbCrDf5LH
   cizKoaDi7F7ZTS85f6nYzzhEUCJ+BpvC4YFMr2utP+ikH9LGbF1YDkz1B
   UAlnj5alwFt+1AhhysA7BCFL5gf9cJdypV9ki5B4BByZiOErdNi+R/Qhk
   Iz0gJZoS5Md9vT7lx1YRRGE2VODbHYLmsBJhc8mnuOuNyini3EViP1hsy
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="112806485"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 11:30:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 11:30:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 11:30:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcRUJmIGad7S1n+UmOFmfyYsErXDXXOzQqchgUlUMN51ZMSQMPUmh8AFPCcGseakYXAZ6YCKGfs1v+uA5Dzj7aS+x8vU9VJNZEkTlMbKYwIdgk8RcrXarP/FmmG7BD4/M9GsC29GfC86m0hKDHmIPR6ox0g6a69I9GKFTxIxH6E+Hvyf4i6ri5agv1RTBAGLqxJWV4lO8Y7TYZ67dx58BNlM+GFXWntbvZ2xBUt18U9wDCqE9t1zYXcuUeZdcCIP9UYCTT/qEm2/TcIBsSQ3GAgugsjAMIwMO+UFl1/fN/d86tIgM5+VH00Qoa+zYJMoC50IQBNQgzd+lXaNSzsbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU1E73PySiuNerKQY4qBD9q6n2T50CGNHPOKh6Evcdw=;
 b=gWzr4CtVDi8cgyOCgepXbc84HUXFNfl4Gt4sP2uz25L6QRgS0I7ow22O0wy5V188RQbJJ3gOzKX6k2rmceEqkmDAmqPe3axSTml5oO0Bh1KyAWSDfmsHS/IPLq6WPSHr0NaYar35su8vdTWUeiQuXbPZQVEOrdV5335Tlh9Ebe0q5FWsoDBkTL1S4cf2Lzhfot//TuKt1btz/7xBKVLZfxMg/8inBRRfG7OpOTHof60sWhLJ6z6wRPAtyVxGERp1ApCe6do5CFOqrlmNPSlamzK/TshvCOfNJ5k6HgNmoRTx/Hk9Hdl/PpDg1NkZYkfiRrLi6ZPSeFrD0K7bQP7V3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU1E73PySiuNerKQY4qBD9q6n2T50CGNHPOKh6Evcdw=;
 b=uafBEyPnk0myRfEnUt5JBqCwpjQsQUsj99bgOEMCju0XhDiC+q6NkY1ZKrzX2pwFm7ap75C1q/GalZZ31vNiQgsUVf4VEIueRaSbxijOYrmMNgGl5ZuPnOxpt340Wbb/NpqCUfn5sUxXMhp1w9M9qwXtN3UPptyXcAHtLfvlDfI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BY5PR11MB3941.namprd11.prod.outlook.com (2603:10b6:a03:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 18:30:00 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 18:29:59 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] soc: sifive: ccache: reduce printing on init
Thread-Topic: [PATCH v3 4/6] soc: sifive: ccache: reduce printing on init
Thread-Index: AQHYw5GW0XsKvKb260KJ1lynBPOtY63V2t2A
Date:   Thu, 8 Sep 2022 18:29:59 +0000
Message-ID: <26842418-9b85-3be6-6800-b6e8e409fa30@microchip.com>
References: <20220908144424.4232-1-zong.li@sifive.com>
 <20220908144424.4232-5-zong.li@sifive.com>
In-Reply-To: <20220908144424.4232-5-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|BY5PR11MB3941:EE_
x-ms-office365-filtering-correlation-id: d3260fcf-5618-4606-db07-08da91c8235b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +KvG26NuE2JpiePI38SySLjC0NuV8sWqLZ+w6w/G2Ba0hHg7YsxwO41FuyCiXv+l0twnoSTmfz4hUUgn5jkibTjbYg5Bzfl9pPQNEoYZxZra3u/PFmzHXGMdcIATci5SI1+DURL56XhBguMok2ztAxrFeoKiUC4NhtHC8XU51CijUH2dCmBBUMcK1opb356XP3liAIsfGobkgNn3dmXXD0vzO9+4jMcUqlceuLRXfVeyxHJuJ5EnLgOcuMNcaIjWDa1uK+dt2v26cpWBwvIgwmA1ivKCqK5byc/vdXN+JEowj4WbcG9RCNL2S1pCZTQCCO1Tf6yRlh6Fs5ltg12H4Exg4jhjief0/RGR6wuKZ98yTIfoxqKvfW8ngtzBoDqw9NuU9MOZsSeCRU6VAtln+eoARv9N1PnbqXCWtKnWf/9IuVlZD1Q2E0eswvycElfBj97zwG7QIpP/15GC0GQh3GQl7HgLTCl0lMRTyyAFuAMPvhxVHPl/n5j7mj3vtHrxXXOYZeDCh96S6sXN4zO/FPwZ2uOcHs/XiAvDgByPTY69piuq2knvlTF8BrGjp3iVhushImQWGPcteXaiJOiGICbu/jsIcSvmQ1zOvu9OXqybLgO0WOXOqq3mK1AZkSVDkG3Z+6kuFYXA1q7JP3o6SKHuJZ/PQR5YKj4KyOzzBZmJQVHOZDgQsaOWFzD0u+QhZQ2c/+iFoWJkass9q+SxVYTK3KKGGciEJK0ps/JEVIpXLF77yvFDHfA05ucAsqAMRgaqxh1MYGRXanBmQeHuhDAHfXCFh1i6PK0lF3FpummGvugHHZ24bD2/X0P1HAGgtJ9wObIEX23ueMQsQxerz7HZI+2KeT87hONEMvVNIX8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(376002)(366004)(39860400002)(6506007)(6512007)(26005)(53546011)(6486002)(71200400001)(41300700001)(478600001)(83380400001)(2906002)(186003)(7416002)(5660300002)(8936002)(2616005)(110136005)(316002)(76116006)(8676002)(64756008)(66446008)(66556008)(66476007)(66946007)(91956017)(38100700002)(122000001)(36756003)(921005)(38070700005)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3A5VkFLTDFkOEdHTkhxV3lLbkZKRFFVNjlBR05sY2txYllqN0ovWHRpSjMw?=
 =?utf-8?B?Y3ZTOFJhNEVReDhJejRlcE5STHVjcGpQNStnVUI1eUE0YXJCa1drcGxZYi9B?=
 =?utf-8?B?Ry9WZTUrU0ZLcFJNNklvRi9KTHdEK3huUTRZWFQvUlplV2x4TjRxZG9IMDVS?=
 =?utf-8?B?M3VJMlJjSGJCcmFIanBnNFl3MTJhZ1Zzd0t2RDNrQkFacTNiOFdTWXo5Ty9X?=
 =?utf-8?B?WEhSNTBxUEZYUVdDenhmSERod2pKL0JOcnRTMkRCR0QvUTBBR1d2cXBKMWNy?=
 =?utf-8?B?N1pZU21iYXIyWlhGZjdnOXJXaGRRbzV1WGE1VDNkTHF4dEJXMGI3RTJGc1Zz?=
 =?utf-8?B?cUh4QjhaTEJCZXBWdFVDcUNPNk5zWC81NHpxdForVmJsWU1uZWNRR3k2Wm05?=
 =?utf-8?B?bVRKZDNZUlh1N2lncHF5ZjRsNUYzVHFHZVFXN3Z0SWplN2dGcXdzL2d4d2VD?=
 =?utf-8?B?WjUrRHNiVjl1K25Ib2Q2K21yRXo0NUJDYjYrUFdDcW5IZTZ3a045SkxUYnYz?=
 =?utf-8?B?cjlyRjJQdUs2OWVQQ3M2K0hpR3puS0JqK2taSnlYL1VqYXFhTlNsQk5lT0xo?=
 =?utf-8?B?NFJoQ0hZUk8xbm0xaTMrZDF1d2JRQVJibGtJdFV5ZHJpUkpISlBGL2lmQlR1?=
 =?utf-8?B?bGd3S2pGWVFmZkxobVRlUkJqTmJPSkJrckhUdDRVRzB0U1FWZDdTRnFMN2gz?=
 =?utf-8?B?amQ1NHRqeHhYcFBXNFpQQ2ZwY3dYSGFyU0tZZHB1L1lIQyt4Wmo3RDhraVBV?=
 =?utf-8?B?VFpOcDhzWUtlMWd2SnBZV043ZlEyeHFVU1o0U0gwTTFzY0hqUng2c0hkVjZI?=
 =?utf-8?B?c2lraWo3U3FKU1pJQWFCOXlIVTRTKzJGSk1pWk85VkZTYlJCT28yNDJYRkV3?=
 =?utf-8?B?ZTRBV044RVpjQ3d6di80Zmc4dlpOZE9IZE1tS2RIZFpDTlNYa283cDhMeSsw?=
 =?utf-8?B?aVRMVnIxaGVjQStwd09IVy9DbmtYL0d2aU5yS21MQm5pb29QcFd1WUppalpU?=
 =?utf-8?B?NXQweUUzREhpR1o0akVXd3lqRDR3c0cyS2UvMnVJT3ZJYUljRk40Y2x0RGty?=
 =?utf-8?B?clB1NTZiREc3YmZEelhBZUMxaTQ2VWh1c3p4RG1CRXdWbHhMSTRFSXZ4b09j?=
 =?utf-8?B?TlFKVGcwR0IycXlpeVRRV3I1Ujl3dEJ1UEVTRzdaODdKSlo5aFBtY2QxYmlY?=
 =?utf-8?B?SitlTnpGZzNrdW5oUHVmZGlGeGtFL1BNZ1BRTHNBYVNXNWVVK3pjdmRNNVNC?=
 =?utf-8?B?aENBOGRTeHlrRm05SytDNXpBSTBpblRydDZ3Mzlhby9VQjh6cnVWOUdXbkp1?=
 =?utf-8?B?ZjZCTXJoaWVIbTZTNTJiU0lVSTZPV3JWbEUzQ2MzMDlIUFVBNzdTL09aWlFz?=
 =?utf-8?B?NWkzSll0ZXpLMkhDWUYxczA2VHVaUlVBMUFjT3VyMDBFV2V0YUpJd29wRmM1?=
 =?utf-8?B?ZmNBZktlM0JvSzg5M010T2NIczdzbzMyOEZidzhSajZKdngxTTd3amhabGM4?=
 =?utf-8?B?WTg1NlV6NXNlVng1TVVKTjFZbUg5UmFIcVlZSXJyMFZvc21yOUJ5MnBSYjE0?=
 =?utf-8?B?K0tUaW9KY3NXeGxldzgyV2Z0VDJlb016K09pUlZhS2czR3dUUlkydFEzblJk?=
 =?utf-8?B?ODhieGYwRjg4Qm9FckpCVXF0aGw1YjlTbGhiTHQvSVNubTEwSER2YTRzczZp?=
 =?utf-8?B?NjE5TTM0MWVPeHFmZkpFNWo0YzJaRDNVQ3lnSjFoMzROVVhNRWcycW01QW1L?=
 =?utf-8?B?Tnd0S0tRYmNHRGNZK3F2d01FK3F1ZWpqTGdhVll5V3QrMzEvekx3azlicGQ2?=
 =?utf-8?B?dmJzdTRaUFdmOWFZVkdLVCticCtIUnYwbVpVRUFpK25GbnBSbFNYeWlDeFJP?=
 =?utf-8?B?NVJrNzNSNnYwQk0ybVBKckFPVE5rUzFZRE1BSCt6YmRLMEU4Q08vWjlTMXlE?=
 =?utf-8?B?ME40UUM0RUcwYVlZYWN3WXdFL0VOek96cGRnc2VIa3E1QkhuMXQ3a2lzVjkz?=
 =?utf-8?B?dko0S1htdXZzdWtFY1JlVUFLeSt5WitBZXlrMUdtMXFRQXUvL2NaQk5oNXQ5?=
 =?utf-8?B?M3F3ME5KRGUxVkc5Y2J3MzFQcC9RVzBXdzRPdGlubzVoMFJ3NDQ2TXNodDlX?=
 =?utf-8?B?TnlmOXBpa0QvL0FCTnZ4a2ZOYTlpd1JiRFdyZFFuaVFKR1JaVlZLOHZXam9Q?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FAE92DB2DBFE14B9683EEF881FA530F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3260fcf-5618-4606-db07-08da91c8235b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 18:29:59.8898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rY9xmhX283OcknXWYxXsWpwf0Rt1lCe/K7y4EeWL4Ajdq5MDPT6YZm5Qr8KrR/fZqqSSpqa34NLOxoAcUi01c7yLmCNrvNU2fNjBesYBCCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3941
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMDgvMDkvMjAyMiAxNTo0NCwgWm9uZyBMaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBCZW4gRG9va3MgPGJlbi5kb29rc0BzaWZpdmUu
Y29tPg0KPiANCj4gVGhlIGRyaXZlciBwcmludHMgb3V0IDYgbGluZXMgb24gc3RhcnR1cCwgd2hp
Y2ggY2FuIGVhc2lseSBiZSByZWRjdWVkDQo+IHRvIHR3byBsaW5lcyB3aXRob3V0IGxvc2luZyBh
bnkgaW5mb3JtYXRpb24uDQo+IA0KPiBOb3RlLCB0byBtYWtlIHRoZSB0eXBlcyB3b3JrIGJldHRl
ciwgdWludDY0X3QgaGFzIGJlZW4gcmVwbGFjZWQgd2l0aA0KPiBVTEwgdG8gbWFrZSB0aGUgdW5z
aWduZWQgbG9uZyBsb25nIG1hdGNoIHRoZSBmb3JtYXQgaW4gdGhlIHByaW50DQo+IHN0YXRlbWVu
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbiBEb29rcyA8YmVuLmRvb2tzQHNpZml2ZS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IFpvbmcgTGkgPHpvbmcubGlAc2lmaXZlLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2NjYWNoZS5jIHwgMjUgKysrKysrKysrKystLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDE0IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2Nh
Y2hlLmMgYi9kcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2NjYWNoZS5jDQo+IGluZGV4IDY5MGMx
OTQ4OTMxNy4uNThkMTRmMTFhNjNhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9zaWZpdmUv
c2lmaXZlX2NjYWNoZS5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hl
LmMNCj4gQEAgLTgxLDIwICs4MSwxNyBAQCBzdGF0aWMgdm9pZCBzZXR1cF9zaWZpdmVfZGVidWco
dm9pZCkNCj4gDQo+ICBzdGF0aWMgdm9pZCBjY2FjaGVfY29uZmlnX3JlYWQodm9pZCkNCj4gIHsN
Cj4gLSAgICAgICB1MzIgcmVndmFsLCB2YWw7DQo+IC0NCj4gLSAgICAgICByZWd2YWwgPSByZWFk
bChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfQ09ORklHKTsNCj4gLSAgICAgICB2YWwgPSBy
ZWd2YWwgJiAweEZGOw0KPiAtICAgICAgIHByX2luZm8oIkNDQUNIRTogTm8uIG9mIEJhbmtzIGlu
IHRoZSBjYWNoZTogJWRcbiIsIHZhbCk7DQo+IC0gICAgICAgdmFsID0gKHJlZ3ZhbCAmIDB4RkYw
MCkgPj4gODsNCj4gLSAgICAgICBwcl9pbmZvKCJDQ0FDSEU6IE5vLiBvZiB3YXlzIHBlciBiYW5r
OiAlZFxuIiwgdmFsKTsNCj4gLSAgICAgICB2YWwgPSAocmVndmFsICYgMHhGRjAwMDApID4+IDE2
Ow0KPiAtICAgICAgIHByX2luZm8oIkNDQUNIRTogU2V0cyBwZXIgYmFuazogJWxsdVxuIiwgKHVp
bnQ2NF90KTEgPDwgdmFsKTsNCj4gLSAgICAgICB2YWwgPSAocmVndmFsICYgMHhGRjAwMDAwMCkg
Pj4gMjQ7DQo+IC0gICAgICAgcHJfaW5mbygiQ0NBQ0hFOiBCeXRlcyBwZXIgY2FjaGUgYmxvY2s6
ICVsbHVcbiIsICh1aW50NjRfdCkxIDw8IHZhbCk7DQo+IC0NCj4gLSAgICAgICByZWd2YWwgPSBy
ZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfV0FZRU5BQkxFKTsNCj4gLSAgICAgICBw
cl9pbmZvKCJDQ0FDSEU6IEluZGV4IG9mIHRoZSBsYXJnZXN0IHdheSBlbmFibGVkOiAlZFxuIiwg
cmVndmFsKTsNCj4gKyAgICAgICB1MzIgY2ZnOw0KPiArDQo+ICsgICAgICAgY2ZnID0gcmVhZGwo
Y2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0NPTkZJRyk7DQo+ICsNCj4gKyAgICAgICBwcl9p
bmZvKCJDQ0FDSEU6ICV1IGJhbmtzLCAldSB3YXlzLCBzZXRzL2Jhbms9JWxsdSwgYnl0ZXMvYmxv
Y2s9JWxsdVxuIiwNCj4gKyAgICAgICAgICAgICAgIChjZmcgJiAweGZmKSwgKGNmZyA+PiA4KSAm
IDB4ZmYsDQo+ICsgICAgICAgICAgICAgICBCSVRfVUxMKChjZmcgPj4gMTYpICYgMHhmZiksDQo+
ICsgICAgICAgICAgICAgICBCSVRfVUxMKChjZmcgPj4gMjQpICYgMHhmZikpOw0KDQpGcm9tIHYy
Og0KQ291bGQgd2UgdXNlIGRlZmluZXMgcGxlYXNlIGZvciB0aGUgcmVnaXN0ZXIgc2hpZnRzIHBs
ZWFzZT8NCg0KT3RoZXIgdGhhbiB0aGF0Og0KUmV2aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCj4gKw0KPiArICAgICAgIGNmZyA9IHJlYWRsKGNj
YWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9XQVlFTkFCTEUpOw0KPiArICAgICAgIHByX2luZm8o
IkNDQUNIRTogSW5kZXggb2YgdGhlIGxhcmdlc3Qgd2F5IGVuYWJsZWQ6ICV1XG4iLCBjZmcpOw0K
PiAgfQ0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNpZml2ZV9jY2Fj
aGVfaWRzW10gPSB7DQo+IC0tDQo+IDIuMTcuMQ0KPiANCg0K
