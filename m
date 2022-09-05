Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05295AD8B9
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiIESCN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 14:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiIESCM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 14:02:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD44137198;
        Mon,  5 Sep 2022 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662400929; x=1693936929;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4vrzNIxJEsTToIDGUogFksBlmMiHAMGToObE3helzWg=;
  b=TIeN2lV7IHVXUPn85IYK0wIAXvFoJL+oXdB/HucimemY+JmHEhvFbBBl
   +Urr3+9MYP9OMTPmjv1cl3a1XqGYz2v6TeY/LBFDs/Ws8sBl+pPKud+dJ
   cmgQMwvY1EJ/JOJThqWaO2kIF8hjqzfn4kFOqe/rj22ZZKgyNHR9pdTEe
   kbmqe34KmYIz9br5btSEqXtiODoc+VuNhgY1G6j8yofEdF8iy1a/02tr2
   AbyKNZoPPvBvw+R8DuZtjOoJBdfjPfV5eh6y0E5leoC1t7nDYbBSWsN6K
   k4qf9c0Ia8WOQQpZg1poDz2cjLaw1waoefmjWReBkwVSE+kUf8JrWU0fw
   w==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="179243691"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 11:02:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 11:02:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Sep 2022 11:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSz3tYh/75VPe0puvZOuSvV9BaV70NWLZTTX63dUR6JN9lAuLx76PZacauc8oMppFHVf0PNi0bdnxA26SHL4HdpSop8zcIhLMbhtN4DA3f+rTPR1fTYJy6UFtCOauGcaVzTpxlMNgcp5dmPSqGUD4gq7mG6R2e44MpgkmKjeUsWMcH3O5/e8dCrykg91nmspBITwew8Fuw5UWBNuGmXlCc6nLENDySTlCuQAIPPwiNPNpmAlAc5gYIGGgm2b3Oqs6zL59c8ax8s9cvbZUtipvaImYQRHz6oq2rZLtmEluLPEu7DjKdfjucpOzq8yee02DVdxOnuPqUdFeK3Pt3ygqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vrzNIxJEsTToIDGUogFksBlmMiHAMGToObE3helzWg=;
 b=gr91Ua9k5YMuMRhwkKDc4wIYWJKmnFf2khdVjKGuIlF95ALTN7TtJhpu0vePRFE7rn/EWySyPUAS40Z5orHLNiEXzTAWewJYox5vHw1X1OAJJOLfFMRQcLqPBZwoa3gAlhIsI0JFDkmjPnAUNaS3Yuxap743Jmc7guEyRqK+ltgfFIQrVRnlfNgH91aQMUkZYtNrIuuPs6ZgbSIt8N2Qb0MTQO/rXwonCa6AnUBBlCcQr6zpLGnEL6JwT6INAy/JzmLVyNPUUZzxIlv6LSvEfQIvY/YtapxnX428V5AOLJ3/2i/doKV0DZD/CQ/tfklfr13MPPcmthLJWGQgLBIeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vrzNIxJEsTToIDGUogFksBlmMiHAMGToObE3helzWg=;
 b=dGsh9P1+aQ+Yw176oNswwO8oEBrrS94OMPewCtsS/XW7IX+2Yn7aeFtN7Mn3Sig4XoYA06MAnPUplFrgsitRldOKQq2WFYOHX1jGRx8vG33RaGtdUxh33mhTo89DvrNyImR/HL4jqdXTNkAVfo3Z970cDN4fk7zSvgP0jCvZxZs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2843.namprd11.prod.outlook.com (2603:10b6:5:c7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Mon, 5 Sep
 2022 18:02:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 18:02:06 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: sifive-ccache: change Sifive L2 cache
 to Composable cache
Thread-Topic: [PATCH v2 1/6] dt-bindings: sifive-ccache: change Sifive L2
 cache to Composable cache
Thread-Index: AQHYwQH9JkERmMJcy0a/nxtQVT6p/q3RITKA
Date:   Mon, 5 Sep 2022 18:02:06 +0000
Message-ID: <c5dd145d-1055-ed85-e6fc-b6b6c5a4affe@microchip.com>
References: <20220905083125.29426-1-zong.li@sifive.com>
 <20220905083125.29426-2-zong.li@sifive.com>
In-Reply-To: <20220905083125.29426-2-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddc9d41c-afda-4273-a86e-08da8f68be76
x-ms-traffictypediagnostic: DM6PR11MB2843:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: slAw+l+kwjkJT91OtOurAGSmbCzwOvqpoWFqA6R7KSRIMgJygtOFzwcH/Ws9y0vXb0IFBaOeO6GurNDrZ/izEMFoJbl6PEBYG3JpHfgrpsTuHzL2BZvc0eIu7oV9/tqSD99q2CGVbB2/ygwIfU2dgSfMWVx7GeDj+VKgPNqnlHVYP5TK/tkq3oYb7piT3Rw51pzME62snzOCgreH73/Qd92lb/MhDjAzAtUT8JKJlOeuhSg3I7YlfGe5tqF2a2W+0HOehFRpC8bapdAiwq+WvTVnQ+9B8/eONqV/iRgL2DolqMTuVVC51rivgoZ4ZAu6umnHWkTRUqWj5e2j7ZY7j9/IH/QpoxqppRgl8xCB5PC7tggFrM6kIdC/OQepghDh7oFC3wbou3vJQtw5XjqjRCzz/qIVI4gJd3e0MsE4xO+H+cmGZOZ2M05gOFSOl3ugova9vFAz73V40Tmm6GRrf6tv71Ikle+fekonE3IlsXUlXmXP8gt7ZcBl6fztcOHHEjmu7jC92l2cZSxzIIbHWA2GVirkY7AkMvWMaRhpiDmZuUpZf5oBktqRpMb+239CFgjqF68nRIUR8eT5oMY3PFkhuJEs0/8OJHTJJqkN1E8jGjgsQs4klAebKi1sCbwubPQAmM8QcZQyR1nxDHRZSAg/F4ghh48Zn5qPpH4LzSR6Qw851aaP1tO8mGY5G+DH2I6K/KBGXLG/0xRK5G5EokFkMZDgM3sgd/yNZvTYwJ7JIX9/fVudTv/poJQ1J2NXLSt5zRbd18ChS1HmgNEoa84JSF6okMle9stu1of60hr7OqMgy4B5db0oe73yanwYQZ09JmXeIfD2nji0wMqCwo7lLh6ftWOXD41bPi+A6Huold+n3yYvXaEhX4+rhnpaRheErpIlupdfobQMtyiFmiiB8ScPEogzvkEo7r62UAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(366004)(396003)(376002)(2616005)(2906002)(31686004)(186003)(38070700005)(31696002)(921005)(5660300002)(36756003)(86362001)(53546011)(7416002)(8936002)(6506007)(83380400001)(66556008)(41300700001)(66946007)(71200400001)(64756008)(76116006)(26005)(8676002)(66446008)(38100700002)(91956017)(66476007)(478600001)(122000001)(110136005)(6512007)(966005)(316002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0t2UWs5MEVwT3BLcnpxQmFSSW1odmdqREltcnBOTzhONUxUNE9kWlZYTDlZ?=
 =?utf-8?B?K09PdUllKzVGdUJsNCtvYTBHcCs5ZzhWOXUvcGVzWmF0TGN4anoyUHNvS1FE?=
 =?utf-8?B?N1BlbCtDV1F0Yjl5dEtZMm0vL3ZQRlFsZ2cwUGZJYWVNc0JqRk1CTjV0bE8r?=
 =?utf-8?B?WCtsQUtMNFV2NHpscHNGMDcxaHVUMkRVN2xFVXJyNFBLNFg5T0w3YWRJMDJW?=
 =?utf-8?B?VG16VndFN0oyNHBkWmZlaGl1VjVoS05aWVowWE01eUprSGRNU3drOHpxZUF4?=
 =?utf-8?B?Zyt6VUIydkJLWGdPcngxREdCcVdRNUFGODJkWUptankyb0ZzUjIzazZYak5h?=
 =?utf-8?B?Q2thSTdVbFh3TmxHVnd1b0d2eWN1a3lUZUc1NHhoYy9Xd2o4YXI1VXVXanN5?=
 =?utf-8?B?SzlqYmNtTGFXVXcwWUVZcmRGS2ZuUHcrYzI2VWZFTy92YzMrS1dDTWFVby9n?=
 =?utf-8?B?bmpaOFBOd3dmZzdPaGtsY3F1YlMyVzM2VFU3WFc0UVBqWmxjN1lHUFVrWjhE?=
 =?utf-8?B?OUxtZlc5WldjNlRiZlBaYTh6NHQ2bGRZN2dMaXJCR2ZlQlJMTXY4UkcrT0hn?=
 =?utf-8?B?bkxKNHVDK20xTS9BemV1czEwaVoxay9KWmRLYk1UNWVMZ1hBKzFYS3RjVmo4?=
 =?utf-8?B?K0JKaVl6Q043UlZWMzd4amQ1U1I4eGJWMTV1Z2dxNHU5bGE4L0R6U1JSODFN?=
 =?utf-8?B?Nlg0d20vYmM0cjllQlRlYy9xekpFK08wUERnSzZWOTBFWDJtaG8xN0hGM3pa?=
 =?utf-8?B?UTQ2K1lrRDgwemFwbU1kL3VQczExdGU3K0JWblQzVkZOaFRIeExEU3llQlRM?=
 =?utf-8?B?TUZpME9NREwvWkh1RXMra2Y2ZXl6L0tRdU4xQUxudFFsc3BkVm5vR2wwVVd6?=
 =?utf-8?B?Z0cyV2dQeUhQNmZLRHdGWFYxZWpiQU1XUnlYOE9yUFZGUGtXUE5LbTNyKzJm?=
 =?utf-8?B?YXUyckVORGdyT2VyeUZaV2NCakFwVGtIbnA5eVJaYzY2TTZqbGtFSlR1RmNx?=
 =?utf-8?B?MWpCSGNIUlZVbHJ3b2dUS3g0c0tTVUNhamlpWGdqcnJ2bEpxVnpvblJBQnV1?=
 =?utf-8?B?d2ZMNG1XeS9UUHZXc1ZRbUtaL2hRUCtjdUJJWGh4SjV2cW1WUUQ3RDFCWUJB?=
 =?utf-8?B?ZjVycWsyaW8rUm5rTDZRQVdWN3ZiMVZUN2s3MXRXcXVrbHFPWkd6cG1sbGp3?=
 =?utf-8?B?WkhFSFhkb2tBclJYVzJ2MFREdVcwNXRrejF5bENmTjZIS2RwUGhuT2FMbkZV?=
 =?utf-8?B?aVpHeENveWZpaE91Y1d6cDMxdFdWaEM1VXpac2tSeHNGTEtJTStPYVJVQU9o?=
 =?utf-8?B?TGZBTWF4c2FSMzZ5bGk1ZWh4MGEyUHp6N05jSGtiaHByeXRSOTdMQlFWLytB?=
 =?utf-8?B?d2d1VmlNK3BQUGp3UnI1VnAwSVViTi9wRVoyaW9yTG1DeVJka0tCcnNWcUoz?=
 =?utf-8?B?MVdiZlc5Ny8vbWFuTkRHQlF6bE5VZm14Y3BNN01pcmQvaXppVldEV0xpMWpK?=
 =?utf-8?B?TkRTaE50Q2xaaXllZGc1aGQrbzEwMlVPMy9VVXhCcm11M0hsOERnVG1XcTVz?=
 =?utf-8?B?NC9wUGJUSkZ5blVJYzl0UURMSjcxb2ZmamlJWG9rWm5rdHhHS0FSK3Q2QWJo?=
 =?utf-8?B?MTl1WW00ZE5kSWZOcFdOQVpOTHRiZWpYVVFFQ1JDRzdoZGd4RDBNNURIMlVR?=
 =?utf-8?B?aXZPSWlGRlNtMW1Wek4yV21YUTNKYWdPaTg3aXJhOXdRbGFBWkl2Qm5oRXB6?=
 =?utf-8?B?MWNFWTltSG53cGE3WU13eENEdEJkd1FmSTkwRVp2TFpidWZDcURQczBXNmhQ?=
 =?utf-8?B?ekNHSXF0MXFZdGRlSDhSam4vcDZOTit1RXpFVGg5emlBVnAySkdXTURpbFZT?=
 =?utf-8?B?cDhDa0o1cGd3dVZxakZNci92NFBKcTlqN1ZBTUhPa1RKMFgvRExlb3pxMnlF?=
 =?utf-8?B?Q0NTNjRQMDA5S0c2OFgwRXZzSmxzZHFZVmZLTlhMeWR2V05iQ3loTTV0NlQz?=
 =?utf-8?B?ajhmL3ozOGNmSW9OY0pLcmx1cC9yYUhscklVRGV4TjRicURCRU00OHpsSnl3?=
 =?utf-8?B?Y0QwVzdINC9jR2szeEhtOWxIUW53TGpHNmNyQ0pFRjBlcTlhaFF6cWE0ZzEy?=
 =?utf-8?Q?CcMK/5+Q8k3USU+8u0/sVAcrM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0182B190CED0E84AB3EED368D57E9C07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc9d41c-afda-4273-a86e-08da8f68be76
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 18:02:06.0851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ehdme7B8Dov3/UGUGHlYcfDyRDrQuRDb29lMGkadznmsNFwGE3fuDYV11WdoTmQzAHpZubnFKNz6C7Hecxo5b5Mcr0AY0PEQpaqb+zpnZOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2843
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMDUvMDkvMjAyMiAwOTozMSwgWm9uZyBMaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBTaW5jZSBjb21wb3NhYmxlIGNhY2hlIG1heSBiZSBMMyBj
YWNoZSBpZiBwcml2YXRlIEwyIGNhY2hlIGV4aXN0cywgd2UNCj4gc2hvdWxkIHVzZSBpdHMgb3Jp
Z2luYWwgbmFtZSBDb21wb3NhYmxlIGNhY2hlIHRvIHByZXZlbnQgY29uZnVzaW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogWm9uZyBMaSA8em9uZy5saUBzaWZpdmUuY29tPg0KPiBTdWdnZXN0ZWQt
Ynk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCkxHVE0sIHRo
YW5rcyBmb3IgZml4aW5nIHVwIHRoZSBwYXRjaCB0byBhY3R1YWxseSBzaG93IHRoZSBtb3ZlLg0K
Tm90IHN1cmUgaWYgdGhlIERUIGd1eXMgd2lsbCB3YW50IHRoZSBtb3ZlIGFuZCB0aGUgZXh0cmEg
Y29tcGF0aWJsZQ0KdG8gYmUgaW4gZXh0cmEgcGF0Y2hlcywgYnV0IHRvIG1lIGl0IHNlZW1zIGZh
aXIgZW5vdWdoIHRvIGRvIGl0IGFsbA0KaW4gb25lIGdvLg0KDQpSZXZpZXdlZC1ieTogQ29ub3Ig
RG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KPiBTdWdnZXN0ZWQtYnk6IEJl
biBEb29rcyA8YmVuLmRvb2tzQHNpZml2ZS5jb20+DQo+IC0tLQ0KPiAgLi4uZml2ZS1sMi1jYWNo
ZS55YW1sID0+IHNpZml2ZSxjY2FjaGUwLnlhbWx9IHwgMjggKysrKysrKysrKysrKysrLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ICBy
ZW5hbWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L3tzaWZpdmUtbDIt
Y2FjaGUueWFtbCA9PiBzaWZpdmUsY2NhY2hlMC55YW1sfSAoODMlKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zaWZpdmUtbDItY2Fj
aGUueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zaWZpdmUs
Y2NhY2hlMC55YW1sDQo+IHNpbWlsYXJpdHkgaW5kZXggODMlDQo+IHJlbmFtZSBmcm9tIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zaWZpdmUtbDItY2FjaGUueWFtbA0K
PiByZW5hbWUgdG8gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L3NpZml2
ZSxjY2FjaGUwLnlhbWwNCj4gaW5kZXggY2EzYjliZTU4MDU4Li5iZjNmMDc0MjFmN2UgMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9zaWZpdmUt
bDItY2FjaGUueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmlzY3Yvc2lmaXZlLGNjYWNoZTAueWFtbA0KPiBAQCAtMiwxOCArMiwxOCBAQA0KPiAgIyBDb3B5
cmlnaHQgKEMpIDIwMjAgU2lGaXZlLCBJbmMuDQo+ICAlWUFNTCAxLjINCj4gIC0tLQ0KPiAtJGlk
OiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9yaXNjdi9zaWZpdmUtbDItY2FjaGUueWFt
bCMNCj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcmlzY3Yvc2lmaXZlLGNj
YWNoZTAueWFtbCMNCj4gICRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sIw0KPiANCj4gLXRpdGxlOiBTaUZpdmUgTDIgQ2FjaGUgQ29udHJvbGxlcg0K
PiArdGl0bGU6IFNpRml2ZSBDb21wb3NhYmxlIENhY2hlIENvbnRyb2xsZXINCj4gDQo+ICBtYWlu
dGFpbmVyczoNCj4gICAgLSBTYWdhciBLYWRhbSA8c2FnYXIua2FkYW1Ac2lmaXZlLmNvbT4NCj4g
ICAgLSBQYXVsIFdhbG1zbGV5ICA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29tPg0KPiANCj4gIGRl
c2NyaXB0aW9uOg0KPiAtICBUaGUgU2lGaXZlIExldmVsIDIgQ2FjaGUgQ29udHJvbGxlciBpcyB1
c2VkIHRvIHByb3ZpZGUgYWNjZXNzIHRvIGZhc3QgY29waWVzDQo+IC0gIG9mIG1lbW9yeSBmb3Ig
bWFzdGVycyBpbiBhIENvcmUgQ29tcGxleC4gVGhlIExldmVsIDIgQ2FjaGUgQ29udHJvbGxlciBh
bHNvDQo+ICsgIFRoZSBTaUZpdmUgQ29tcG9zYWJsZSBDYWNoZSBDb250cm9sbGVyIGlzIHVzZWQg
dG8gcHJvdmlkZSBhY2Nlc3MgdG8gZmFzdCBjb3BpZXMNCj4gKyAgb2YgbWVtb3J5IGZvciBtYXN0
ZXJzIGluIGEgQ29yZSBDb21wbGV4LiBUaGUgQ29tcG9zYWJsZSBDYWNoZSBDb250cm9sbGVyIGFs
c28NCj4gICAgYWN0cyBhcyBkaXJlY3RvcnktYmFzZWQgY29oZXJlbmN5IG1hbmFnZXIuDQo+ICAg
IEFsbCB0aGUgcHJvcGVydGllcyBpbiBlUEFQUi9EZXZpY2VUcmVlIHNwZWNpZmljYXRpb24gYXBw
bGllcyBmb3IgdGhpcyBwbGF0Zm9ybS4NCj4gDQo+IEBAIC0yMiw2ICsyMiw3IEBAIHNlbGVjdDoN
Cj4gICAgICBjb21wYXRpYmxlOg0KPiAgICAgICAgY29udGFpbnM6DQo+ICAgICAgICAgIGVudW06
DQo+ICsgICAgICAgICAgLSBzaWZpdmUsY2NhY2hlMA0KPiAgICAgICAgICAgIC0gc2lmaXZlLGZ1
NTQwLWMwMDAtY2NhY2hlDQo+ICAgICAgICAgICAgLSBzaWZpdmUsZnU3NDAtYzAwMC1jY2FjaGUN
Cj4gDQo+IEBAIC0zMyw2ICszNCw3IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgb25lT2Y6DQo+ICAg
ICAgICAtIGl0ZW1zOg0KPiAgICAgICAgICAgIC0gZW51bToNCj4gKyAgICAgICAgICAgICAgLSBz
aWZpdmUsY2NhY2hlMA0KPiAgICAgICAgICAgICAgICAtIHNpZml2ZSxmdTU0MC1jMDAwLWNjYWNo
ZQ0KPiAgICAgICAgICAgICAgICAtIHNpZml2ZSxmdTc0MC1jMDAwLWNjYWNoZQ0KPiAgICAgICAg
ICAgIC0gY29uc3Q6IGNhY2hlDQo+IEBAIC00NSw3ICs0Nyw3IEBAIHByb3BlcnRpZXM6DQo+ICAg
ICAgY29uc3Q6IDY0DQo+IA0KPiAgICBjYWNoZS1sZXZlbDoNCj4gLSAgICBjb25zdDogMg0KPiAr
ICAgIGVudW06IFsyLCAzXQ0KPiANCj4gICAgY2FjaGUtc2V0czoNCj4gICAgICBlbnVtOiBbMTAy
NCwgMjA0OF0NCj4gQEAgLTExNSw2ICsxMTcsMjIgQEAgYWxsT2Y6DQo+ICAgICAgICAgIGNhY2hl
LXNldHM6DQo+ICAgICAgICAgICAgY29uc3Q6IDEwMjQNCj4gDQo+ICsgIC0gaWY6DQo+ICsgICAg
ICBwcm9wZXJ0aWVzOg0KPiArICAgICAgICBjb21wYXRpYmxlOg0KPiArICAgICAgICAgIGNvbnRh
aW5zOg0KPiArICAgICAgICAgICAgY29uc3Q6IHNpZml2ZSxjY2FjaGUwDQo+ICsNCj4gKyAgICB0
aGVuOg0KPiArICAgICAgcHJvcGVydGllczoNCj4gKyAgICAgICAgY2FjaGUtbGV2ZWw6DQo+ICsg
ICAgICAgICAgZW51bTogWzIsIDNdDQo+ICsNCj4gKyAgICBlbHNlOg0KPiArICAgICAgcHJvcGVy
dGllczoNCj4gKyAgICAgICAgY2FjaGUtbGV2ZWw6DQo+ICsgICAgICAgICAgY29uc3Q6IDINCj4g
Kw0KPiAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+IA0KPiAgcmVxdWlyZWQ6DQo+IC0t
DQo+IDIuMTcuMQ0KPiANCg0K
