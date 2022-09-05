Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F65AD8EB
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 20:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiIESO5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 14:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiIESO4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 14:14:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02C21D315;
        Mon,  5 Sep 2022 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662401694; x=1693937694;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=gTh1bo3gwQjE5qX+btW0O1YCsHldWeRV1CU9grgw05o=;
  b=kJw4//CAPyHHsAqsmMys2PwO/nIqf08mDcdGKVIJsiwBGE4BPTvJr3rW
   UcE3IejjYhDqfzFVNaL/J83eioYBvuddodTVy+BchjzmjaH3gqbPlOA2V
   wLcfQy74ifYecpAnsBkzUqy61qXhXkf3WtJSpgpgxvoIl+s+q6makXPui
   0XKf/x9JbacL81bH4CRKO1w+IjEe2NnFNj4n4LOoqqs1qbglnAZWe1NHQ
   YidA5TgyvlNSjChPFku1Vl41G480YYZlnqCnNclKcnC65mEj4/baof9UR
   cZ07fXsIIi/THXVVDtTEN4EqZq4k5FuunZfsEowpDNCSs5StRc5rIKxZ7
   g==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="112249876"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 11:14:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 11:14:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 5 Sep 2022 11:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvYfq0sOAreQf8S9NFz0WJHuHxwLrsfmd8HoAFACT/HrviltreCg154h17zdj20Swg5XZp5gg7tH3A1f5irpSp5H7brQgpf2VqjiwUqeQfYxw3XNPXcACkcayBmDIU/1GUVZ3I6Z2/8V3DGooMzEyc7MQy+ZKSw+LcVuZ6jPZj8Q4T3YygHzj/q55EMQkuMH1GyPz4lT4GEvQcA2WgkIWt18KOtrjH4VoxLUCBmZ0h4LD9N/t7U4v5ZNStR14WlZSUVtcGA0t4HQuxMIalisR+IhETNZvBx4ip8atb06/g3cGIaNS+ltVe71i/irEVQ1204PjSSKHqVAjil2jqVbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTh1bo3gwQjE5qX+btW0O1YCsHldWeRV1CU9grgw05o=;
 b=VEqC15udjQLm7r40VlWfri5tmuZijnINjSMDdobQ+6SCjJ2UhC33M3w22rCDvXWvWrTob4UGCif5zuWKlAtm0Zxp2oTXcJHEYGi+7DD55dmKeeBdJ0uii3kRON9cdTLPG0SxOHGmqkI1d3MYst0OV2BocnpgVeBCnxoJ81xEc8k8ZT3+UKeA/GCF5bGpZnuE3IVUYywV+K1b7171CkE24X0KkPZAqrNMchtX7e4R2hgbCfea5wuKL6WNcTqonwA7uZfLmxUagJ8NSEKoyaEyliQTX9Bc6J4+/1SNuXt7b/TrRfRmyxtNaOKrGEhTtcM7e/sW7JQGiXCKkfUevf2/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTh1bo3gwQjE5qX+btW0O1YCsHldWeRV1CU9grgw05o=;
 b=Ji4iUWXLM3g8yN/PmSVZxL/B8q5v8Uk2/O79lsDljWB6T6HvrEvVWlQifqZRjxDuzwLNAtkJnmO/GwzzVHh0zAS0XwTTIbR5wOVlSNzF9kNuqA7HZTnvVZJ0/MG7sxrE0nJo3b96QPL5HhJYmvhb2qsnanAaqtvyzmmSL9k4gT4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3189.namprd11.prod.outlook.com (2603:10b6:a03:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 18:14:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 18:14:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] soc: sifive: ccache: determine the cache level
 from dts
Thread-Topic: [PATCH v2 3/6] soc: sifive: ccache: determine the cache level
 from dts
Thread-Index: AQHYwQH8Nup3uTCbTkOlLkhrlQaRlK3RJMGA
Date:   Mon, 5 Sep 2022 18:14:49 +0000
Message-ID: <cf98f606-a392-37e9-be92-cb854afb4951@microchip.com>
References: <20220905083125.29426-1-zong.li@sifive.com>
 <20220905083125.29426-4-zong.li@sifive.com>
In-Reply-To: <20220905083125.29426-4-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c13be1f7-2dfe-4bfa-59ae-08da8f6a857f
x-ms-traffictypediagnostic: BYAPR11MB3189:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G+fgSHw9bUr53OaIrOEMkuIfmgrbeGuTMb01Wrp5GR2TBi+BSkwf9zQkVM4IqtS1P4OnkGkuLZKYVginkaerMbfKrFND8Rx8I5v5NV7OZQOyhGo/qJnN+V9ITfEiibXJnU8fd18UBezW8U/oUnB1E6r6oJhxitEYKoXSqMuaqL2n2VO+nFqWIQo4K4rVFy3TwqAWFftScyzEJXtFPLLW+d4/P5xWYri4zNZsoYDU57VUOCBedXSJ6EZfEBdd3OHmbmFQzlRYw9tsPE5v/enQnu7XYwH5mBsmRpGBhvj6xM9PnfCK/6wsCcpzUn8wjeBqJvyesxZ/o0EqbdNOZTG2ZxcCujSS60cjIqfs6I3ahlGiWaZX/lCOzBONTY1itVzzDPP68XdLpo+aKIbAbpNGs0FJ4jwcSIG2ojM1QgOZqcXyMZIhkXSvVvhkswTPzHjJEkn8Mup94O481NKfHoYuBJ9AOfu6GlPcNATlj33+ZB7C/iyuGsLAXk3yPaTc3fpq1ktiHFQl9zvlUxR4ot5n69DZkOsaDqDHqjJUYCyRqyJY20vSAPgQsXV8zw7b0bhbXlczgVExY1kuUhSKXgi/BYTmC8Gpq6lEMM11IXcc1OQm0HSnI+wG7NhRJ1eHsj0giw7SVjWCQwA6F1F28pJQ9Rp/7yP6RfsG4G4PkoxbvSMmOQAgq4UysPsGyfwvhibt6+sxqwnjfmkcAuWoGfIQxqumg2PcWObm5KpWtLpmFSxdLTI8gSyVioMUvJrRQK3ZBJ0f/aRYxqFzBjYwPKsoXVRSxXEM1lMI3wFAhkd79FQTRavuBQ8mcP8dCXZpkELMgqH5gqBi2WTLFl2IilU3Kr64Yfh3Fkm/2pNzDSqLjzw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(136003)(376002)(396003)(31696002)(26005)(6512007)(6486002)(86362001)(71200400001)(41300700001)(6506007)(478600001)(38100700002)(38070700005)(921005)(186003)(122000001)(53546011)(83380400001)(2616005)(91956017)(31686004)(2906002)(8936002)(76116006)(36756003)(64756008)(66556008)(66446008)(316002)(8676002)(5660300002)(66476007)(66946007)(110136005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3dhQmhqVUxYanBjc1c5NDVORVVDd1Zra0tpMzBzdlozczkyN001K3BPQjlG?=
 =?utf-8?B?NWRBRnNUZnJyYTRkUzBrZlNBVFBzRDV5Z0llc2ZhYUdIRUMrSEJ3d3kwdUhK?=
 =?utf-8?B?ZitqaGYxaUpsOE8waExtNUZGcm9RYTNnUVBsSWtJL0ozNGNwdWxZUk96cW9t?=
 =?utf-8?B?RmVna2RNVUd3c3JraGM0Nm1EM0p3QXF1N1N0Q0ZnUlIrUlpZcXRxYXR3RS9F?=
 =?utf-8?B?U2ViZVJ1MXEzdW01c1k4OWN6T0ZkK2wrWTBVcFRsaGJUQ2NGZDl1ck9NVnQw?=
 =?utf-8?B?K0pNSCtQVHc4anViMkVNaU81Yk5sLy9WdVVuaFlqcEFIQnJBUmVyelJQZE9F?=
 =?utf-8?B?c1NXcFdGQ0tqdUZ6bGdhQzZtL1dnYm01c24xeFNqVGVJWG53Y1N5SkQ5MExC?=
 =?utf-8?B?UVpOcUE0MHNDSnBJcVF1ZXE0TUtPWVg4SVNtRG9pU29yZ3FERWp5eGd3ZEE1?=
 =?utf-8?B?ZGl4MUNZOUVWZERSckpDY1R3ZlVLdGZDSWJ5Y1d5SDFqUTZEOFcvbFp1blhn?=
 =?utf-8?B?VGhYS05UNXI1WXlrV1hCalRmUC9TRXJmQk5mV3kyaFJaYVoyUG5YV25LaFlB?=
 =?utf-8?B?S1BhYTFleEpzamtaYXhOdWp2aTZnSGRoUUFrSkFUTm5ZOTZ6Y0EvMjhWU3hv?=
 =?utf-8?B?U2NzeHI5UFFrazZIa1F6VmVsN09NdXdNU3VqbFJ5dkdLWmJ2aDIvR0R3WndY?=
 =?utf-8?B?RlZRMVpEdFVFR0hGV1NWanM1LzAvcUo3bHJDMzVMZ3ovMU1jMzJydGM2NWx5?=
 =?utf-8?B?Qk5KVmMyc1VJeW53ekY4NzJjc3BJWnl0TE8rdWw2eDdwRDdWMTZCNTNWbmJq?=
 =?utf-8?B?dzV1bXU0UVJyTTRHYWZmQ0ZBZzREK3RjR2UzVWZ1Zml0Nm9LejlBd2JjRlNk?=
 =?utf-8?B?cXljN2xLVHEyYjUydUNqdW9UemdaUWJzalIwQlZGWUpZNDhsakJ5ZHl3OU9H?=
 =?utf-8?B?SXVUMEpOeUQwUjFScWphR1RYamlUcUszaHd2TzBLWkc4akRsdjNoTjE2eEpO?=
 =?utf-8?B?RmI3VTYzTGlFamRmNkRZblI1bHdtWmJhTCtwNjRia055NUtWd1lKL3lLSGJI?=
 =?utf-8?B?KzN5TGpXcGtNRzRMaFZHZHhSaTlUSWtzRkVrQ0JwRWZxTllkVXFzeWM5RElh?=
 =?utf-8?B?S3RYdDQyeXhDK2NIWGJqc1pXZEhsd0hTR3ZzejdsSG9sejNOMXYxcTFXTjVJ?=
 =?utf-8?B?OXZYSU1aY25ISkRwMEdWZkh3TFAvOFFwdjRKdWRpR1kyUTNnNGlFME14TDBS?=
 =?utf-8?B?M1dPTUZSL0NkcjFxZHNqUTU3Yy9JdUVWQUFUSE84WnAwUllXbWRVSDBuaTl1?=
 =?utf-8?B?VElWZ2x5cGdyZ2doVlJlcjR2V3lRUmFQNmR4R015ZHdMVUZ0Z2hVQ2lIQW9h?=
 =?utf-8?B?aFc0aTV5djArRjE4YnlOQytpUDhtT0JzVWQ0SHY1K3VxSlMyZ2h5R0t0a2c3?=
 =?utf-8?B?b2E3NzZQcy9QNHN3NVRVTzkzMDhOM2tjTUxoMnVGVUlKcVpOSmVDdmp1enNT?=
 =?utf-8?B?SHJud3AwYUZXQ3lhOHRXalIwYXZpOUtwejEraWNobTF5U3ZLUEppQjF6UzhH?=
 =?utf-8?B?SXJ3cGpLY1FRdmZhbVQ5Rlp6RU5EUHN3WDRnZHdnZlBvUHdPVld4QXczN0dR?=
 =?utf-8?B?bTR6YjR2bTQxUGFrNTc5alpuUzlqOCt5eDhyNS9NZCs1cFdzMTJTekVKbm4w?=
 =?utf-8?B?ZjJWWE1SK1JCNWZiZkRtbm1LU3U0ay8ybWRqZTlSbVRsNXYvUWJvbVg0bnpN?=
 =?utf-8?B?N2JMUkc0bko2MC9yOFM2QWtOSnZiNURENDdJTU5oYWZlTUVZUTV1bnJ5STZQ?=
 =?utf-8?B?UUUxeWFsOEc2aHpKVldvR1pLbEhwTStuZit6dWVicE0zaWs1Yk85V3h5Mk9T?=
 =?utf-8?B?RVZBWmx4WE4wZk5kc0oyUTlYZG5ER0w2S2tnN2E3NEdvaUY2bmgwcm84cVlS?=
 =?utf-8?B?YWQxdzZHdlowQjJSTFFOOFlTUWtyS0lwZUhHanVVVXFyWXFoTXhWZW9WNDNV?=
 =?utf-8?B?UFByV1NzejlFcHlsRkRocGxUYkpoSnR6cWk1b1dNUnZGbTZVL2tXb0MrOE0r?=
 =?utf-8?B?NFJod09UYjMwL2VUSjFEOVRxMjBTTmZkS0FYZ0o1TlJidk51TzVpUjk4Z1dP?=
 =?utf-8?Q?smWINaPe66TZG186FZwGaxDNL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <446C5876D885AC4BAFED9CEB5447FBFE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13be1f7-2dfe-4bfa-59ae-08da8f6a857f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 18:14:49.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSeTNPqH8f+OQuPapG4/CGDvk8u/sWo1DqTwAdczawxcvH/UgvFg42m6nbDwYg1VBPrbBUnUkMUz2C5KEm+2w7DhYYh+quuNYBSXSEbthjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3189
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
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBDb21wb3NhYmxlIGNhY2hlIGNvdWxkIGJlIEwyIG9yIEwz
IGNhY2hlLCB1c2UgJ2NhY2hlLWxldmVsJyBwcm9wZXJ0eSBvZg0KPiBkZXZpY2Ugbm9kZSB0byBk
ZXRlcm1pbmUgdGhlIGxldmVsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWm9uZyBMaSA8em9uZy5s
aUBzaWZpdmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBHcmVlbnRpbWUgSHUgPGdyZWVudGltZS5o
dUBzaWZpdmUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hl
LmMgfCA2ICsrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2Nh
Y2hlLmMgYi9kcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2NjYWNoZS5jDQo+IGluZGV4IDFiMTZh
MTk2NTQ3Zi4uMGUwZWI4NWM5NGQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9zaWZpdmUv
c2lmaXZlX2NjYWNoZS5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hl
LmMNCj4gQEAgLTM4LDYgKzM4LDcgQEANCj4gIHN0YXRpYyB2b2lkIF9faW9tZW0gKmNjYWNoZV9i
YXNlOw0KPiAgc3RhdGljIGludCBnX2lycVtTSUZJVkVfQ0NBQ0hFX01BWF9FQ0NJTlRSXTsNCj4g
IHN0YXRpYyBzdHJ1Y3QgcmlzY3ZfY2FjaGVpbmZvX29wcyBjY2FjaGVfY2FjaGVfb3BzOw0KPiAr
c3RhdGljIGludCBsZXZlbDsNCg0KQ2FuIHlvdSBoYXZlIGEgc3lzdGVtIHdpdGggYSBjb21wb3Nh
YmxlIGwyICYgbDMgY2FjaGU/DQoNCj4gDQo+ICBlbnVtIHsNCj4gICAgICAgICBESVJfQ09SUiA9
IDAsDQo+IEBAIC0xNDMsNyArMTQ0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVf
Z3JvdXAgcHJpdl9hdHRyX2dyb3VwID0gew0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1
dGVfZ3JvdXAgKmNjYWNoZV9nZXRfcHJpdl9ncm91cChzdHJ1Y3QgY2FjaGVpbmZvICp0aGlzX2xl
YWYpDQo+ICB7DQo+ICAgICAgICAgLyogV2Ugd2FudCB0byB1c2UgcHJpdmF0ZSBncm91cCBmb3Ig
Y29tcG9zYWJsZSBjYWNoZSBvbmx5ICovDQo+IC0gICAgICAgaWYgKHRoaXNfbGVhZi0+bGV2ZWwg
PT0gMikNCj4gKyAgICAgICBpZiAodGhpc19sZWFmLT5sZXZlbCA9PSBsZXZlbCkNCj4gICAgICAg
ICAgICAgICAgIHJldHVybiAmcHJpdl9hdHRyX2dyb3VwOw0KPiAgICAgICAgIGVsc2UNCj4gICAg
ICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KPiBAQCAtMjEwLDYgKzIxMSw5IEBAIHN0YXRpYyBp
bnQgX19pbml0IHNpZml2ZV9jY2FjaGVfaW5pdCh2b2lkKQ0KPiAgICAgICAgIGlmICghY2NhY2hl
X2Jhc2UpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gDQo+ICsgICAgICAg
aWYgKG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAiY2FjaGUtbGV2ZWwiLCAmbGV2ZWwpKQ0KPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ICsNCj4gICAgICAgICBpbnRyX251bSA9
IG9mX3Byb3BlcnR5X2NvdW50X3UzMl9lbGVtcyhucCwgImludGVycnVwdHMiKTsNCj4gICAgICAg
ICBpZiAoIWludHJfbnVtKSB7DQo+ICAgICAgICAgICAgICAgICBwcl9lcnIoIkNDQUNIRTogbm8g
aW50ZXJydXB0cyBwcm9wZXJ0eVxuIik7DQo+IC0tDQo+IDIuMTcuMQ0KPiANCg0K
