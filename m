Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C401B5B25FC
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiIHSkQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiIHSkQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 14:40:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5B98285E;
        Thu,  8 Sep 2022 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662662415; x=1694198415;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8ONF0ZrYAcUu9jRfiFDeKnfbkf5M+VxFN1q1cvPnxE4=;
  b=gx4nSrNAAszNI4J1A9w5IY/3VvU/pI6ZiEBKO9tXarhYx4ZDzdLfMBQY
   gydyYl+LQbrUHLn03s0akRVHTLawsEAOqKnCH7UBmsc32aO4JOiyA/RGZ
   +jMos7QypDYlmDkvHAnUde/rFgpxXRgE5ZGFYEg0WAwKXUv45hKSm/XP0
   Kb+FCocxON4oljBPcB6AZwNn363BXAOStm/wY1h9j2Ac1GHq1/qCS6Oqm
   vlx+Fmz1+jKIaBKvC5Ehl3Aok38gXtSqGM4GU61PnYchuggoHTxY0H7Q7
   YexU/pdBQfQOP5s+jhcTQlDqhc1of6mNMkgAUpYvxnhtdb7tt4Xyk2/O5
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179622077"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 11:40:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 11:40:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 11:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL2+maKZaOUN7Ol7H4IQyc8qFkQYmjI7Tpn8w/kpqdU/WVOga0x7zS76dUkRsgPvJnkD0v9k7LYmQ3Odk7kOvm2w4j3oWuHnKYY8SxzHPGY8ho9HOHK9mSh74ZKKT35/GugYXlhkBjp60RARy9p1XYbge+NZZ0+0ojaScP4Di551C/c24pJpJCxdnVvxbNF0NJ3SbLxAdxoVKCHRd5bCbXJ/Tpr63uZyZ9yPad3jTSiED6D3uMFc5XodvX24WkflSsbOViOk8EVBkD+ce23capTI1IYjz85wcAe4LNoKs6zcEjdY3eEHKfQtPCyPuv6jIDgvjbMBvVzaZx+zpmVcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ONF0ZrYAcUu9jRfiFDeKnfbkf5M+VxFN1q1cvPnxE4=;
 b=IP3CSZ5zKPeZREIU0RgTYCK4Hl01Q9BxLXDVouObm5ZboXMTzBNuXkH2bMG8SmffCF2M7XFh7ePzaS4r0WIAqbEyeP6vlQGNXaxBB6oK6qEeRz3hwR44wpBAvEJDnFIWu7Y3U14937eGWId8prpgn6Q4XVOGdqA63tRSoyd3EhgK/5RkVuoYpDEhiLoqk6DKLuTemREaZyidSgrqypNN5UgSPcfzr5onkUlBxhdM2UjI/9gGqU7ewhEIXcKR2Jd2NOjQjbBIPfCUqoNUUDhwp3yowpMzlFuaH2CgrZA9hndNEabZvi2TaUVI/+tDNgO5ht6lDODZC7ZxFYBcOhMlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ONF0ZrYAcUu9jRfiFDeKnfbkf5M+VxFN1q1cvPnxE4=;
 b=NlVcYiIH39Xu2l0zr4Lw20gYhSJcGmKC+g0sLLaUYdbhO2uBSmrZaWIWTORZ6EK53eCIUclcKGQHp8GGezMtCaxlEz0OtybNgHCEvbORzpBjGKminc/qunWq0hJkDPMgkIxCzGhkfPV3hEGMjlkyzH64goia7VH0lo+OGDEsW3E=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH0PR11MB5364.namprd11.prod.outlook.com (2603:10b6:610:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 18:40:09 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 18:40:08 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] soc: sifive: ccache: use pr_fmt() to remove
 CCACHE: prefixes
Thread-Topic: [PATCH v3 5/6] soc: sifive: ccache: use pr_fmt() to remove
 CCACHE: prefixes
Thread-Index: AQHYw5GhawiXHMEYgUiKfN64A8yNka3V3bMA
Date:   Thu, 8 Sep 2022 18:40:08 +0000
Message-ID: <36fe0073-7fa2-9733-7041-d9f70da1a5ea@microchip.com>
References: <20220908144424.4232-1-zong.li@sifive.com>
 <20220908144424.4232-6-zong.li@sifive.com>
In-Reply-To: <20220908144424.4232-6-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|CH0PR11MB5364:EE_
x-ms-office365-filtering-correlation-id: 65866ad1-f8bf-4e6c-15a1-08da91c98e5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J794hwrT35OWwnYoki3GA3TDf6yklX+JcW+9Wg7EZZOkNNihwSKFo4us0owovnsn3amWDHcrYurk3iPowVX7j9vMajoJ6hXFeogMV9l3EZS5Oa7Tz3Jrj/tIf58kNKjpL24J6yUwHsUowkgj7pXRRrkG03i/K82F+/c31ddTrADP/PPscL6jJb+2sRwL2x5QlHAqcVsYrbrZiHnDR0VxmcK5/0JaBQbxRlwFJ7VP4L6hXwRaldJd1AYRKlHIwWCUf+VlcqnbUxLRjGt8EbJVYFeg3C5q9uIkwXxRP3RCU8ATxJRl9m/Xfm8srM1LUJmXjMSOYduXTArr+TbH/0/l0SXu/mmh6C7506UhDX3OMAPcQu4ktMV9NlQsquFHt1A+HXPe3zQvVeRbPn7qnEwgq3Ty1aqbhqmuHhNYBIYVwsjv03nwvQA7YB8VR5mPYbw30FQcuTB7CiBEfjBIZXKe1b3zAtbsKKpom9tDQWhYVY7fquGWNpL2k0l12eR3UJ9Q3TEQcpfZ1fmdUrp8BsuN+nr5jx1jg4F9PTE04wbHgm0RqG78ZuF2rIpnu/2YOEWgghDCV/8HCrn4qpJNlf1A9arxZaR1E79Fn2eZeG/IZLkz4mbX1CEiqQZG61hgj15azPYexjRXCR19XCFEDoRkZi2iRo/I4RWxPgDTOLQZ1wQTZMJFlBC/M36ABhl8DfJTdiUpV7sWfmErNSpLX31lP9mgZ4TsglJzl+VFZoS57NPOLBqd28iG1bPgGAZxFPuN+P9c0rN1pYxqyJGPVahODQFRK8Ua0PpahjduApMnw0/qngUGWdX+CxF283o0h/LRLUEsz1JND+duI5ptrIAneaPSAilSyXQbPMUqjgG46ow=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(346002)(366004)(2906002)(83380400001)(38100700002)(2616005)(186003)(110136005)(36756003)(8676002)(66946007)(76116006)(7416002)(91956017)(316002)(66446008)(64756008)(5660300002)(8936002)(66556008)(31686004)(38070700005)(26005)(71200400001)(86362001)(921005)(31696002)(66476007)(53546011)(122000001)(478600001)(41300700001)(6512007)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWFka1dBVlVDMm9CclNlZnVQbTlzbTFkbTFQRldZYkxqYmdHN0NZc1dqNEVF?=
 =?utf-8?B?UWJlTWkxcUZCbllUbUt4blhLdzBpWUhhbEExTWRqaUplbk50aEdzL1IvQmRz?=
 =?utf-8?B?TlNSMDJ1aE8zbWpzRVhnbkxpRjA5R1NEamJmcGQ3WWZSeGVOek16VFVRSW0y?=
 =?utf-8?B?N0RKbmlwZTVMOU9PUExnLzFxM2wwQUMxVFdJYzdSV2dpdVBPcHZHSm04Y0N5?=
 =?utf-8?B?a0MvREQ2eXJuRTF6SjgzNjdSN3FqU0Zjejl3b1ZlUnFvRUtlR0owMlpWS043?=
 =?utf-8?B?ZE9DMk1sWlNrTWs4OGpIVUpPYW43Y1FLblRFcjJpc25MRG1Jc2N2cXZKNVFr?=
 =?utf-8?B?d2pSRmRtY1RBZHI4R2I1Q2VraVJESXRnVWhkdDZVaDJrMzVwb3pBSnVrUjZz?=
 =?utf-8?B?Y2dWV3hZQVRvb2E0aFp5d0lsOXRjN3VseUVLRHQ0SllhUk50ZHU1bGEvbFV2?=
 =?utf-8?B?OEFQRUk2eDdzRFRXcmlZUlVPempIczNiS29yWC9UYkc0cDVBK3NzNlZBa2tW?=
 =?utf-8?B?ZFAvdFQwR1FyVzVxVTNoeEZqd1pxL2F5M0RjRGYvL29RNi9TUXdDbDVaRGwr?=
 =?utf-8?B?RkQ3T1VrOCtvYWhMaHpDTVBtd0RxbFRxYmdsUUtBcTNnZlFQTmg4R1ZvTWNF?=
 =?utf-8?B?NHVPdDdCLzJnbjl1NHpoQTJ3Mk9uSnlYSG1TalVhc2xHRyttRDgrV21ZN0hE?=
 =?utf-8?B?SDh6RXNoUlQzbHR5VzF6RVZoZDQzYzh2dnp5cGhHWklGN1F6TGdxMmpTSzlZ?=
 =?utf-8?B?OUQrd0ZCL2hSZS9KMXk5Rnd5QS9hcXVURm1GZ1pYUlJRRC9PMDhSYlIyc2JQ?=
 =?utf-8?B?Q2dMeUNWZEQ2MVdUMGZ2anFBSG1neTBBU3RrQzRXWjc2SWQyUjVJSndKRTUx?=
 =?utf-8?B?MkdvTmNSbXRCa3Jvck9NRW5aVWRiVk1HQjFqU1JSbzFuY2ZXR1FwOHZ3c1BE?=
 =?utf-8?B?Tk56QW01SER2WGtkU2VsRm15eG1ia0x0a2xkVXhGdDloVWlvMGdxNFhLazdD?=
 =?utf-8?B?VERXM3F6NkFnWXZvbFlmb2dLS3ZWTDN1a2ZyTk9QaTFsQlF2NkVDbTd5NjNE?=
 =?utf-8?B?WFdIY1QycGtidTQ3aWh1clVQN2prQ2QzbHhPUHUvSU5EYm02amZqSGtoZVlx?=
 =?utf-8?B?cS9pZ25PME4zT2c4OWNwM24xUURZNjY4TEV4U0Fpd1lkV2JRYXlHcW9xTjJk?=
 =?utf-8?B?dVlyamw1Rko4M1JaQjlwY0VLdUMwR0hIcXRTY1BnSUc5eTRFTUZlOHZiM2Ru?=
 =?utf-8?B?NGpiRGdHMTFRb0FxY2htYWJESkZzTHJCMVVyVzhGdVJQVmxpcUhrRmEzYnJ2?=
 =?utf-8?B?L0xEUWJrUmt4TzI2TjU2ZWdNWk5OZk50Nlk3UUdQc2RZb3FBWW5EQ3RhNnhY?=
 =?utf-8?B?bW9yZlVkOFkxODVpR0VDMmpGWE9mQmw1cFdxdmE1YUVMekhMUmNnK2R1R0xv?=
 =?utf-8?B?alpRRERsVFVLY2Z5UE4wZU9sRzJGeFhob0pUaG4wSzVKbEkrYlJqNWppbWFV?=
 =?utf-8?B?U2I3L2x4TmcxRDdnbExBNXJRS05rMGRHb0YxSzlwUnVQUnF5WHJ0ZzAvbVph?=
 =?utf-8?B?Vms4VTZFT0o1SytYM255OXVPUXMvUVd0R3l0WXc4N1JMeUJRbUZ0dEs1ZnRX?=
 =?utf-8?B?NkJFeGJBOEFnRi9jdWZaaG9hdjVnU3dYYXFVTjd2WlFTM3Y3ZW5LZ3ZleUlm?=
 =?utf-8?B?VEgxOUVHM0xsbFJwMzN3WWZRTkEvcXlhb3c3SHNQNnRCYjdNb1V0QTNXQ29m?=
 =?utf-8?B?WWdxWUtYbHhkMGFXSTd2eE5yc2RiNkxoK2U0dXYvRk1TNlpac3JySGE5WGdU?=
 =?utf-8?B?VmN6QXdrZ2N3NnpldytjbVA1M3gwV3RJdlg3NjM1QllHcVlBWEtSOTcrYWNL?=
 =?utf-8?B?Y0ZMNUNSb1AyejNxQ2t0c0dWYy9lRStIa3FsYjhMeVBlZE92WFRsR1RGTUI1?=
 =?utf-8?B?VHFrcjV6bWxkZ2VyZGpBWUYxeUlZbU94MkdKd3dpSE9GUFUzd3VGaFVUVHMx?=
 =?utf-8?B?Vk51VlVkeFBpR0xKSHlhMzBselh4cEtFOUtnQ2YrMFJqMm9MZG5xSzg1L3F3?=
 =?utf-8?B?SU05c244MUZudG5aVlVPdTdiVzdVQlZLVVRRb1B5QnU1dTdQZzNPNTh2eXdn?=
 =?utf-8?B?K0ZaWDBxWnZyeGFuS29xUGpkdldCYUoxUVhWN3VVKzRUQWN3ZTcwdGZ1SzRn?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <803CFA9C7A7D0E49A060B2AF4270149D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65866ad1-f8bf-4e6c-15a1-08da91c98e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 18:40:08.9044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heatiuvS6LPDnflXqfRiefzTEXklQ6NLd5qquEhL9jnWY5ywLiV1deabtMNfFnCNqBMezzp+r7mXDsW1cMvMuSv5f0AaM1ziPoZOuhxxV20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5364
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
Y29tPg0KPiANCj4gVXNlIHRoZSBwcl9mbXQoKSBtYWNybyB0byBwcmVmaXggYWxsIHRoZSBvdXRw
dXQgd2l0aCAiQ0NBQ0hFOiINCj4gdG8gYXZvaWQgaGF2aW5nIHRvIHdyaXRlIGl0IG91dCBlYWNo
IHRpbWUsIG9yIG1ha2UgYSBsYXJnZSBkaWZmDQo+IHdoZW4gdGhlIG5leHQgY2hhbmdlIGNvbWVz
IGFsb25nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmVuIERvb2tzIDxiZW4uZG9va3NAc2lmaXZl
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWm9uZyBMaSA8em9uZy5saUBzaWZpdmUuY29tPg0KPiBS
ZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0K
YnR3LCBJIHRoaW5rIEJlbiBtaXNzZWQgYSBwcmludCAtIGEgcHJfZXJyKCkgaW4gaW5pdCgpLg0K
DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2ZV9jY2FjaGUuYyB8IDE1ICsrKysr
KysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2NjYWNo
ZS5jIGIvZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2ZV9jY2FjaGUuYw0KPiBpbmRleCA1OGQxNGYx
MWE2M2EuLmIzOTI5YzRkNmQ1YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2Mvc2lmaXZlL3Np
Zml2ZV9jY2FjaGUuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2NjYWNoZS5j
DQo+IEBAIC01LDYgKzUsOSBAQA0KPiAgICogQ29weXJpZ2h0IChDKSAyMDE4LTIwMjIgU2lGaXZl
LCBJbmMuDQo+ICAgKg0KPiAgICovDQo+ICsNCj4gKyNkZWZpbmUgcHJfZm10KGZtdCkgIkNDQUNI
RTogIiBmbXQNCj4gKw0KPiAgI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCj4gICNpbmNsdWRl
IDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCj4gQEAg
LTg1LDEzICs4OCwxMyBAQCBzdGF0aWMgdm9pZCBjY2FjaGVfY29uZmlnX3JlYWQodm9pZCkNCj4g
DQo+ICAgICAgICAgY2ZnID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0NPTkZJ
Ryk7DQo+IA0KPiAtICAgICAgIHByX2luZm8oIkNDQUNIRTogJXUgYmFua3MsICV1IHdheXMsIHNl
dHMvYmFuaz0lbGx1LCBieXRlcy9ibG9jaz0lbGx1XG4iLA0KPiArICAgICAgIHByX2luZm8oIiV1
IGJhbmtzLCAldSB3YXlzLCBzZXRzL2Jhbms9JWxsdSwgYnl0ZXMvYmxvY2s9JWxsdVxuIiwNCj4g
ICAgICAgICAgICAgICAgIChjZmcgJiAweGZmKSwgKGNmZyA+PiA4KSAmIDB4ZmYsDQo+ICAgICAg
ICAgICAgICAgICBCSVRfVUxMKChjZmcgPj4gMTYpICYgMHhmZiksDQo+ICAgICAgICAgICAgICAg
ICBCSVRfVUxMKChjZmcgPj4gMjQpICYgMHhmZikpOw0KPiANCj4gICAgICAgICBjZmcgPSByZWFk
bChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfV0FZRU5BQkxFKTsNCj4gLSAgICAgICBwcl9p
bmZvKCJDQ0FDSEU6IEluZGV4IG9mIHRoZSBsYXJnZXN0IHdheSBlbmFibGVkOiAldVxuIiwgY2Zn
KTsNCj4gKyAgICAgICBwcl9pbmZvKCJJbmRleCBvZiB0aGUgbGFyZ2VzdCB3YXkgZW5hYmxlZDog
JXVcbiIsIGNmZyk7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgc2lmaXZlX2NjYWNoZV9pZHNbXSA9IHsNCj4gQEAgLTE1NSw3ICsxNTgsNyBAQCBzdGF0aWMg
aXJxcmV0dXJuX3QgY2NhY2hlX2ludF9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRldmljZSkNCj4g
ICAgICAgICBpZiAoaXJxID09IGdfaXJxW0RJUl9DT1JSXSkgew0KPiAgICAgICAgICAgICAgICAg
YWRkX2ggPSByZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfRElSRUNDRklYX0hJR0gp
Ow0KPiAgICAgICAgICAgICAgICAgYWRkX2wgPSByZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9D
Q0FDSEVfRElSRUNDRklYX0xPVyk7DQo+IC0gICAgICAgICAgICAgICBwcl9lcnIoIkNDQUNIRTog
RGlyRXJyb3IgQCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9sKTsNCj4gKyAgICAgICAgICAg
ICAgIHByX2VycigiRGlyRXJyb3IgQCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9sKTsNCj4g
ICAgICAgICAgICAgICAgIC8qIFJlYWRpbmcgdGhpcyByZWdpc3RlciBjbGVhcnMgdGhlIERpckVy
cm9yIGludGVycnVwdCBzaWcgKi8NCj4gICAgICAgICAgICAgICAgIHJlYWRsKGNjYWNoZV9iYXNl
ICsgU0lGSVZFX0NDQUNIRV9ESVJFQ0NGSVhfQ09VTlQpOw0KPiAgICAgICAgICAgICAgICAgYXRv
bWljX25vdGlmaWVyX2NhbGxfY2hhaW4oJmNjYWNoZV9lcnJfY2hhaW4sDQo+IEBAIC0xNzUsNyAr
MTc4LDcgQEAgc3RhdGljIGlycXJldHVybl90IGNjYWNoZV9pbnRfaGFuZGxlcihpbnQgaXJxLCB2
b2lkICpkZXZpY2UpDQo+ICAgICAgICAgaWYgKGlycSA9PSBnX2lycVtEQVRBX0NPUlJdKSB7DQo+
ICAgICAgICAgICAgICAgICBhZGRfaCA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNI
RV9EQVRFQ0NGSVhfSElHSCk7DQo+ICAgICAgICAgICAgICAgICBhZGRfbCA9IHJlYWRsKGNjYWNo
ZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9EQVRFQ0NGSVhfTE9XKTsNCj4gLSAgICAgICAgICAgICAg
IHByX2VycigiQ0NBQ0hFOiBEYXRhRXJyb3IgQCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9s
KTsNCj4gKyAgICAgICAgICAgICAgIHByX2VycigiRGF0YUVycm9yIEAgMHglMDhYLiUwOFhcbiIs
IGFkZF9oLCBhZGRfbCk7DQo+ICAgICAgICAgICAgICAgICAvKiBSZWFkaW5nIHRoaXMgcmVnaXN0
ZXIgY2xlYXJzIHRoZSBEYXRhRXJyb3IgaW50ZXJydXB0IHNpZyAqLw0KPiAgICAgICAgICAgICAg
ICAgcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RBVEVDQ0ZJWF9DT1VOVCk7DQo+
ICAgICAgICAgICAgICAgICBhdG9taWNfbm90aWZpZXJfY2FsbF9jaGFpbigmY2NhY2hlX2Vycl9j
aGFpbiwNCj4gQEAgLTE4NSw3ICsxODgsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgY2NhY2hlX2lu
dF9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRldmljZSkNCj4gICAgICAgICBpZiAoaXJxID09IGdf
aXJxW0RBVEFfVU5DT1JSXSkgew0KPiAgICAgICAgICAgICAgICAgYWRkX2ggPSByZWFkbChjY2Fj
aGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfREFURUNDRkFJTF9ISUdIKTsNCj4gICAgICAgICAgICAg
ICAgIGFkZF9sID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RBVEVDQ0ZBSUxf
TE9XKTsNCj4gLSAgICAgICAgICAgICAgIHByX2VycigiQ0NBQ0hFOiBEYXRhRmFpbCBAIDB4JTA4
WC4lMDhYXG4iLCBhZGRfaCwgYWRkX2wpOw0KPiArICAgICAgICAgICAgICAgcHJfZXJyKCJEYXRh
RmFpbCBAIDB4JTA4WC4lMDhYXG4iLCBhZGRfaCwgYWRkX2wpOw0KPiAgICAgICAgICAgICAgICAg
LyogUmVhZGluZyB0aGlzIHJlZ2lzdGVyIGNsZWFycyB0aGUgRGF0YUZhaWwgaW50ZXJydXB0IHNp
ZyAqLw0KPiAgICAgICAgICAgICAgICAgcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hF
X0RBVEVDQ0ZBSUxfQ09VTlQpOw0KPiAgICAgICAgICAgICAgICAgYXRvbWljX25vdGlmaWVyX2Nh
bGxfY2hhaW4oJmNjYWNoZV9lcnJfY2hhaW4sDQo+IEBAIC0yMjcsNyArMjMwLDcgQEAgc3RhdGlj
IGludCBfX2luaXQgc2lmaXZlX2NjYWNoZV9pbml0KHZvaWQpDQo+ICAgICAgICAgICAgICAgICBy
YyA9IHJlcXVlc3RfaXJxKGdfaXJxW2ldLCBjY2FjaGVfaW50X2hhbmRsZXIsIDAsICJjY2FjaGVf
ZWNjIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQo+ICAgICAg
ICAgICAgICAgICBpZiAocmMpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJD
Q0FDSEU6IENvdWxkIG5vdCByZXF1ZXN0IElSUSAlZFxuIiwgZ19pcnFbaV0pOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBwcl9lcnIoIkNvdWxkIG5vdCByZXF1ZXN0IElSUSAlZFxuIiwgZ19p
cnFbaV0pOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmM7DQo+ICAgICAgICAg
ICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiAtLQ0KPiAyLjE3LjENCj4gDQoNCg==
