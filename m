Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10F45B25BB
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 20:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIHS2q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 14:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiIHS2j (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 14:28:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1962CF3420;
        Thu,  8 Sep 2022 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662661718; x=1694197718;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=xNXE7gdPHDGsV3iCXn01/4LNkbpTmEql1mEZoxnsllo=;
  b=sfxVgbmvedj3hrGptqXLPCjYkYpEMfU9oKQDtAqmrVb1RtL7tss3wMbo
   q+7V23iRwEg6MgqsjxdfTKghaUGKmrCT29AMqehTcYxs6CKVQdYidnnF8
   QO7EvO2ota9b+jDc/cHorD8YuHDVG7ar6jVsOVoz0Q3Ux3rceKXS8a16C
   Q7rGxB1Bt884Ktbil56LAPKXT65RZb4CJ6OK0CAPzQE9Xp5iz1oVXIIgT
   kE619d+pe6GDcPSzA+Bi0qM6rUY9wVHBd0cdaS7sRnI/xqgaxt9TtzFJX
   aNZflqYbS9/lwd0jxVPM75gIohH7T+S+W6pHc/esoqjy4fI7by9YOJsri
   A==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="176275033"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 11:28:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 11:28:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 11:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG4PhPZhAWkpM9PegBVyGi5OLIhTuUcioV8o86wMbT8Ew9ygA0fp0UfLm9HzgfvjxthL4j9Yu/mK2Q3biwUjSCV9tA1Pxc6tn3xAl1ZuVXXE57HRAOo0T0jVx2f/lkfEpWixM4rUZxLME96ehmbFM0futO1qqihGwlEM672EtJByTx8P5opJ8ySb5ke7qpuHHX+PAZ7AM5ylLwxZbLPRbbogGBG7Uh41A3MXOiBZy0ZgGqc2OPsKtUDiU0SuLeUGS7dh/C2nXoQsM0VhIKgwGUplxQW6nUYwJPmNtD1SEe5dLhUziyDEJxJyDM2wuUgkMaMEdpsx7qkIG4gFMr+bJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNXE7gdPHDGsV3iCXn01/4LNkbpTmEql1mEZoxnsllo=;
 b=MDhBFKOV43eIdVmpFbRFwiNCtvls3uBl8HUzT2To1UyCHM9o1B9DYtVbRrJIKzuf9Is4Or90en8CyzYX1enI//b+rHxQ0UrXM9Kz+dsvUt0kgQkqgAsGCch5rQJd3vtkMmuqNNTaSY3aLuRKA6sPRj5WTp6Uf5lAASmiOvF4trlz828+xWOT4gJ+WKtHU8ok46LTPDqq9pNTJtuxqZfPhV4YpLqEjYU2GCYiEg1/nWGP60lTqZUHsCo/x6lzcrKzFvV/uFhnDOfs4Zl/cYH+F10w28qh5dtBaVd4aRXfqUj4ANeQP9GLbnhdJmEvR5FFlP5mgVdX9YAiJJ8HgLwHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNXE7gdPHDGsV3iCXn01/4LNkbpTmEql1mEZoxnsllo=;
 b=dM8usO4AWYOTxZvyuIPccY3sMhAZqntdICxkpJ2rkkfzsYSRe4HQ7U/0qnY1vhxzTd2LjJ/w6dA0e7pHVuf9/965OWs211OA/0VxoVIrjJnFS5fl2bZsMJRf8ASBoHosW79eEJ25iiaZggZHQLURaJq4pof1ViVaH2pLyL3/tQk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB4393.namprd11.prod.outlook.com (2603:10b6:5:206::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 18:28:28 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 18:28:28 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] soc: sifive: ccache: determine the cache level
 from dts
Thread-Topic: [PATCH v3 3/6] soc: sifive: ccache: determine the cache level
 from dts
Thread-Index: AQHYw5GXUivIqG0dYUesCVnSc8fMJq3V2m+A
Date:   Thu, 8 Sep 2022 18:28:28 +0000
Message-ID: <632b2853-1543-e3ba-b34f-39f3f4fdaddc@microchip.com>
References: <20220908144424.4232-1-zong.li@sifive.com>
 <20220908144424.4232-4-zong.li@sifive.com>
In-Reply-To: <20220908144424.4232-4-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|DM6PR11MB4393:EE_
x-ms-office365-filtering-correlation-id: b6f6e816-d945-454e-a4b2-08da91c7ecde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQbACzgUFZjngi/TxJGRF/eUtcs96Zp6JjlXRFj6ghvBsfKKQ1Lr5yiPwSn7y1XxGJX7n4B0JMS625fHtb+m/E3IVayhe3jvhUEnnONwgFYX78WGdOJWeC+9zoZ9qpf9JhBEcrbJkAp86kpmd8xN8WbJXGoWWND32gZiBVmN5hIKxS2tTKhsLxyIK+kduA7vYYa6K4uiYT+Tv3htcfrHS9UgHf1xN1qrAJIFu7dIxP/CAFntRtOgbXi5hlT60JMv4pZ+dAz1OtRl4fz5CRvTSPRrVtNztGpzmvJLXbIenyzNi0zpIas23qkF+MX9SLk+qSXoUV9xRdmZvTXV9d8tiURSLex1cyd8yWH9F/C/wErdM4/BGLvHTCKLSP0ANslSnXcpOF/DHYK2MsDhQqmFc2POVmUM+4dlmX0QHzo9aE7LBKlpWskiHkY/HaGVbUiB4C0HcHdRykmv7OM03kuWEhb3p6jwqxbmT34lO0DUG6cYaj2PY0BupLL4jprTYg8vPopxEK2tocgrK/F8buY4X4yJE+YZdPlZEWSrsjC7+ohz64dLXBNeP0C8TB1WdTg3bgRciHirgU42sD2pL3aOv42zSSZYTf5pkGcHoF/hFvj4Rzns+xFv6rQ+X7QQA4K3RR22c8tbbJCrayIfiWAJcfh7mjgDA7H/0BpPjc8t32zjlzgr4btjulz4XlRoP03kpx1/kdCjKgSIylIOP7xkGViLS0U0sZTMcXIPNiYWlZ4Gr3Yduk51Ezapsg78G5MLAqbFBTchAsp+jr9cLxj/kS23ETxK923nQmB6dyAo5JgKHHXscncH3KbcaWNqZP5Ii1Okig44R84H7K+m6fuljp0IdZdvNrweSjH0c1HdcuQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(396003)(366004)(26005)(921005)(6506007)(38070700005)(6512007)(86362001)(53546011)(508600001)(71200400001)(6486002)(41300700001)(186003)(83380400001)(38100700002)(122000001)(2616005)(64756008)(66556008)(8936002)(91956017)(66476007)(8676002)(66946007)(76116006)(66446008)(36756003)(5660300002)(2906002)(7416002)(31686004)(110136005)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkZwMG9TZU8wcU1RL09JaDNtZFV2NzVrbDFpcm8raEY4WjBnRzVleU03bzJu?=
 =?utf-8?B?YkdUMks5ME4vTzVwclhyZEg5K2x2L1NWSFMzSlgzUWg1N2JjRS9tZWQ3Uy9U?=
 =?utf-8?B?U2dBL0g5ZFN5R2orMG1RUWx5TGZickNpS2NCSGFzTkpiTVJtTjF4QWovdGk2?=
 =?utf-8?B?YnlHRS9XdDk3UG5MV3o4QVh5aks1SGJsN2tQdGlnbEFhdWRVUFdyMkFDeWFN?=
 =?utf-8?B?UzlQRnZPZ3NqazErbjB1S2NkTm9TZEM4UkZOYVdjdkdoOFJPS0kvNWczV2FG?=
 =?utf-8?B?Z0I3MW02TDMxbStDS0d6akxNdk1ScXRTcTlvK0F0NnBZV3FSZGg1NzR6ZEtB?=
 =?utf-8?B?ckh3ZzhkMmNKNFNtYlBuTGVyclZNbnpSSlRQcHQwV3BocGNLUGpwTlJXMkto?=
 =?utf-8?B?QzIvR0JPUmo3OTZWTGtTM1pCaG9RTnpLbTY0N0Z0UHMwV0o5WE1WUVp1cVFL?=
 =?utf-8?B?QkNDKzVNbCtMTjdiK0JWOTA5cG0reFBkWGtDV1JNM3RjSmRsTmoxRUpwZzdZ?=
 =?utf-8?B?aHdYcm55a3Fmc1FVbDVvOXRtQ1hxUVEvdzBFZ01PR1hhcnJmb1BtakRGZ3lC?=
 =?utf-8?B?ZFNZYUFqQ2E4akZROVBtT0NwU2NHVVJ0Sk40Z2NML3FoN0pYNHcreGFRbklU?=
 =?utf-8?B?dmpWRy9oVDZaU29obWJXYzBpYXBYMFFpQ2JwM2NrZmRGdmRmYzRGNUZ5eWpW?=
 =?utf-8?B?a1Ewekd5MWZpbmxEY0xVMFgyTG9qZFU5bEtVNnNwMTR3eTZzS2JwTDRUT1cz?=
 =?utf-8?B?R0FFQlI4aE5QN042TFBkNmZ2cGcxVTljd21td1cyRGhZR3FoUW1OTHRJcnBo?=
 =?utf-8?B?aHM5QThnZUYxTEQ5WmZjTXBHVldudWsyM2RML3ljVDFPN1V4dDRsTkJpdVJJ?=
 =?utf-8?B?ZlYrK1hJNkV6NlBMSGIvVUdGbUpWWWpDcU9OYUptNG0zUWtKMERxMmVoWjI4?=
 =?utf-8?B?SERFWVJ6UmJLRHowcEMwYWFGc2RyWUowWEdvbVlWdE9tTUlpTGt6TFRPYVYx?=
 =?utf-8?B?TjErSk10WWFjY2lEOFBEczV4MFJhSDdxd3hJekNKOU8zOGQzZFFUS3NHcjZS?=
 =?utf-8?B?S0hCWGpCMnJIcStVaVV6NTF1d1k2RXhrYUZDRkxWMFh3cDNJMGlqS3hIL3lJ?=
 =?utf-8?B?V1BZT0hmYmlBdExLT3VCMjFBTGRmYVdKbUp1ODZ6NFMxWHpyaXJCdVNhbFNh?=
 =?utf-8?B?ZjRYb0gxZDJkNkt2TXdQWUxhMGJoUTRud0NXbWRXL2RBMEdlNjdQYWpvWGN4?=
 =?utf-8?B?UzBkdEJKZkIrclhZUVJBd2M0em85N21hL2tWd3gyTzBzbXo0a1JxVkVWV09v?=
 =?utf-8?B?L21yQVVqOWZnYmlsOVI1aWVvY1BNYjZVZVNMWFVsb3RaVVUxZHhwRGlJZFFR?=
 =?utf-8?B?UTkzRDN5TXl2bWt4RkNmRDg2SjQyRkZZYXowZDF6eG1lQXZTSXpnQUR1WjU1?=
 =?utf-8?B?eVN3dDY4dUVUSFVxR1NaMDRtSXBDN1c2VFVZWk5taUZzc0JHZ2ZDMmZaWTdC?=
 =?utf-8?B?T3pFbHFhWkIzTlQvVythMGJPUEdQcE41RFRncko1eVU0UDBuWWhQdGpmVjYz?=
 =?utf-8?B?cVlURitnQUh2cHB0SUxSK2UzTHJkcHI1Tm9OWkdEN2lZN3pIUUNidXZjaHpZ?=
 =?utf-8?B?LzhJeEtiU0tKdkxDakJkS25OWkpKYmpuNWgra1U5YXF1QlIwZk1iMUh5ZEtQ?=
 =?utf-8?B?TG4xUU55bkMwOXhpSXRrTU9MbEh3emI1WktPTUU1dVU3Vm90eE1QbmdXQ0VH?=
 =?utf-8?B?eHN1c0FLbFp6ZTVibkEvTGVpNkwwZ2lTem1PRERwTHBidFVqN0F5YTJVWXpZ?=
 =?utf-8?B?d2MydHIxa21kbkIweklpbDVXQWJXTFl0QkNZdmdneW9sbzRERkE1cGpXZkl5?=
 =?utf-8?B?WnB5Rkd3T3lVMnVTRDUvVG11UlB5T3JLUmJPZHhoU2s5YS8rNkJ6SWFudnVz?=
 =?utf-8?B?N1VENlI3b0dtWEJHQ1ZTRVgycnVPVUtTeHFwOHk0VXRjOHpxa0FkTUljbWhN?=
 =?utf-8?B?Q0tlaE9YVnFCdnV5Nzdra3lSREtPMnVDVUVCNE1IaWpxSSt0RHZGTDFxQmtr?=
 =?utf-8?B?eVhjZ0YvQnhWczIvTGJ1NDNEL216OWx2eWF2R0VTUTVBSW5jSTlZaGJCZzZV?=
 =?utf-8?B?LzBzOVp5dWRSS0FkbThNMHRIQzNRRG5nVVkzOURZVUdzTEFXQWg3T1owNlRL?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC32E681C24FEC4F9E5F38CF1A810597@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f6e816-d945-454e-a4b2-08da91c7ecde
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 18:28:28.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utK43Ne2XA9QJ7TF3TlCmhNPYC/NxwpCZLWV9i+K2bCVy6ejdu+T9d6jlEF+hfC72jrByZYNCEFEg3r3zzVEOeVpvTZ3jWqFGDW8b/I1Ijc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4393
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
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBDb21wb3NhYmxlIGNhY2hlIGNvdWxkIGJlIEwyIG9yIEwz
IGNhY2hlLCB1c2UgJ2NhY2hlLWxldmVsJyBwcm9wZXJ0eSBvZg0KPiBkZXZpY2Ugbm9kZSB0byBk
ZXRlcm1pbmUgdGhlIGxldmVsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWm9uZyBMaSA8em9uZy5s
aUBzaWZpdmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBHcmVlbnRpbWUgSHUgPGdyZWVudGltZS5o
dUBzaWZpdmUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hl
LmMgfCA2ICsrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2Nh
Y2hlLmMgYi9kcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2NjYWNoZS5jDQo+IGluZGV4IDk0OWI4
MjRlODlhZC4uNjkwYzE5NDg5MzE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9zaWZpdmUv
c2lmaXZlX2NjYWNoZS5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hl
LmMNCj4gQEAgLTM4LDYgKzM4LDcgQEANCj4gIHN0YXRpYyB2b2lkIF9faW9tZW0gKmNjYWNoZV9i
YXNlOw0KPiAgc3RhdGljIGludCBnX2lycVtTSUZJVkVfQ0NBQ0hFX01BWF9FQ0NJTlRSXTsNCj4g
IHN0YXRpYyBzdHJ1Y3QgcmlzY3ZfY2FjaGVpbmZvX29wcyBjY2FjaGVfY2FjaGVfb3BzOw0KPiAr
c3RhdGljIGludCBsZXZlbDsNCj4gDQo+ICBlbnVtIHsNCj4gICAgICAgICBESVJfQ09SUiA9IDAs
DQo+IEBAIC0xNDQsNyArMTQ1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3Jv
dXAgKmNjYWNoZV9nZXRfcHJpdl9ncm91cChzdHJ1Y3QgY2FjaGVpbmZvDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKnRoaXNfbGVh
ZikNCj4gIHsNCj4gICAgICAgICAvKiBXZSB3YW50IHRvIHVzZSBwcml2YXRlIGdyb3VwIGZvciBj
b21wb3NhYmxlIGNhY2hlIG9ubHkgKi8NCj4gLSAgICAgICBpZiAodGhpc19sZWFmLT5sZXZlbCA9
PSAyKQ0KPiArICAgICAgIGlmICh0aGlzX2xlYWYtPmxldmVsID09IGxldmVsKQ0KPiAgICAgICAg
ICAgICAgICAgcmV0dXJuICZwcml2X2F0dHJfZ3JvdXA7DQo+ICAgICAgICAgZWxzZQ0KPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+IEBAIC0yMTUsNiArMjE2LDkgQEAgc3RhdGljIGlu
dCBfX2luaXQgc2lmaXZlX2NjYWNoZV9pbml0KHZvaWQpDQo+ICAgICAgICAgaWYgKCFjY2FjaGVf
YmFzZSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiANCj4gKyAgICAgICBp
ZiAob2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJjYWNoZS1sZXZlbCIsICZsZXZlbCkpDQo+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCg0KSSB0aGluayBFTk9FTlQgb3IgRUlOVkFM
IGFyZSBtb3JlIGNvbW1lbnQgcGF0dGVybnMgaGVyZT8NCg0KRWl0aGVyIHdheSwNClJldmlld2Vk
LWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQo+ICsNCj4g
ICAgICAgICBpbnRyX251bSA9IG9mX3Byb3BlcnR5X2NvdW50X3UzMl9lbGVtcyhucCwgImludGVy
cnVwdHMiKTsNCj4gICAgICAgICBpZiAoIWludHJfbnVtKSB7DQo+ICAgICAgICAgICAgICAgICBw
cl9lcnIoIkNDQUNIRTogbm8gaW50ZXJydXB0cyBwcm9wZXJ0eVxuIik7DQo+IC0tDQo+IDIuMTcu
MQ0KPiANCg0K
