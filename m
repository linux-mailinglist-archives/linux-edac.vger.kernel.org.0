Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116785AD91A
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 20:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiIESgi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 14:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiIESge (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 14:36:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC345F70;
        Mon,  5 Sep 2022 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662402991; x=1693938991;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NGo5kJmRmHx+S+g7F/wltr42EEE7eV6IJ126ZXwnn7M=;
  b=F9kNqOIpGei4nO9Dyqbx/IWI3Cfgg2XxNB3mHx9D5wkOGB0IRicu88A5
   C8jrEX4DyD872s5IlqRQt4+CMp3YD47S803IXiUuTi8G3E0nWTinbrDIy
   6dr4tbkKY1tQtZivhzp6Y4ClCeLDqw8CWPwNpDZ5+/ZEc8KysfCdoTU90
   TwyqHgVsTxCZ1VQIE1Tea9Eszeg9gyCjBEao+nYtvtm3D1HCDUeakP0nE
   qGfpEGV/OBDGb8e6judTcvAhMxqxeBY8xBy00t8KQC9YvKO7tMjgaslWV
   PorqV9+C28XqHSx6jj7Kp2sJC3Uhuk3HN5RinQ6PXe4AIM98tMRZ052BL
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="179111455"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 11:36:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 11:36:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Sep 2022 11:36:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqNHilS6jmbIF6Bh5kmy8H0hPpZ2QJ9eoNIVG2Z4s0uizPVwHCDJ1gmKt/jrbSYcL6B6AYyIceIB1tEN0x7BErKMS6KoRuoBj0z2S1oQhrhuL9RUPffXCQHpiW6H4Qje5weXy0xKQ8igp5XuH13RnvW7lOv3mO2jOOYpi7NmkY9n74NAfCop/kbehwm9PZ9JPo4KfL1kmgwydenGGpsEO/lm8VDH92DG9tGLiTyZJl5ZPXSZZYPy0bTeVrtE1EN8W0x2mCS3TnJSh5UAGcxBu4L62hwPUv1fa3bE5yihkG93kqA2YUdn0322fXsrDpO+j8BGfMMVSXcjiCLnZUAfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGo5kJmRmHx+S+g7F/wltr42EEE7eV6IJ126ZXwnn7M=;
 b=CuK6Iuwv7GyP+vSoHiJ1UMtOS5oc4QbblcyA0PMfaUw7CAmccbHfAoMS/LGae+7Zpcsn0KjFy3LvbqQdofwoMkZ8EUMpgieGJe7Axd3uf0DvGpBsdw01LA8QxH2RFFk8X+rgOdib3Cr1n3DsoAhjLcMbrAzVKzxDwM9XNpXQ/pVByjgNJnkOJ/9a3/9dkrrJ++iR5mrRtt39qcoAJgJqUZIpZ7zAP+Z5FGknsOzTAZhJFyGx4NnM8tbkhmPY2gBt9nIoU3tJGDDdpdtvYFeZIHQWEsa1nz43u8P9wNRXR27vICgkqyO3YRlqJR1lhYPGIfZ8iOXyP1YTewIdNFe4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGo5kJmRmHx+S+g7F/wltr42EEE7eV6IJ126ZXwnn7M=;
 b=db88lz1kNDnxNZfsthwGK8PXTFIUwMcrUmw6A9fDi9rzUX23xSjxw7udu8ua5RgfIzLLKgfsJn8PzjuGbVI6YkmagPaATeUT0lpqCEeP8uKf9sNDjc+YSGBBaFng9FKrExgUxYg4pXk7u6g7w0N9Qpq/6HvgJVTzlschUjbBQAs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB6698.namprd11.prod.outlook.com (2603:10b6:510:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 18:36:15 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 18:36:15 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] soc: sifive: ccache: reduce printing on init
Thread-Topic: [PATCH v2 4/6] soc: sifive: ccache: reduce printing on init
Thread-Index: AQHYwQIC7mihKguHYUucGYj3s4hGeq3RKr0A
Date:   Mon, 5 Sep 2022 18:36:15 +0000
Message-ID: <490336f2-5028-499f-d78f-620e083b3c61@microchip.com>
References: <20220905083125.29426-1-zong.li@sifive.com>
 <20220905083125.29426-5-zong.li@sifive.com>
In-Reply-To: <20220905083125.29426-5-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 964a03bf-b1c4-4243-d636-08da8f6d83da
x-ms-traffictypediagnostic: PH7PR11MB6698:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwF9WsGaVEgg1adeV/8upEI59V/6fA83dONXwj9ns3NLqnhBMtbY3zH5KXPS9jcPYfAkxHwdV0yFrCjgbqAEUesMpCZYfAPlUl/UiwN23j/7GWpEENU5DfBG+GpReOL3dEH+eoqs6iqIq5t/DaPxLzSB0ud1LOH+UV9TlI5mVhmj1c2cMekvhajP/Pqdqpe4L+nEpEklMEa7D11hFBmkDAGibcOMcrzdASsuFhu+ZFxczyyv457TzFF67dwi9dfAgw1TbQ5yIxjS4Ckzh5EpWUjavTkxwFqFjHmoqRQGEN+0yo+2dmvfI2kk65IlPczgxmW0RiRCnBs4ZIm6RmZTGce/Clps63Hlf0clSb2rQ/dj31eALtbDk90Yvxj7m7OQQq6OiXWiP6m/fh/tYurfRJbzxQzjXctcmAGv6GIdRtE5rtGH9rL3/uUYlWNuwC+kw0ejuTklotGOXw9rGb/CZvcN9YO3Usu18w7SvvGUVz8QNjwzoFrsCocXRBIbIdLDAaHpQrQVRcqYMgHKs1g8ErOFw2G0tHd6c0tuPY+wVRN/mNzo/DmA9wDyaALsFD8f1UtZ2ac/ER+3sb+RH0HAySu7PCJK4SBSzTPWV9XGmlgZnQtswbR7fcyBSDHqfXGxIEtIyAz/wXoY0xE6n2mexq4nuxeMgfma6vCJYV0sjN+zm7W0Hir8/4g9n41nJaC6yNl0c0gt55Ui5zCV4R+kEKkx9cliErG+JAzQP4L+H7JwV3lUYj0JSkSkjkiMf9mHMfd+rymrYA1r9DASBm9pTns/5FrkeqVL6XsLGBxJ3/v830ZMImYvZ0uu1ttsD9iC+4mcgGkspdxIEZLqhpDJgzzxT1b3+/Oz/HM5B5liro4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(346002)(366004)(39860400002)(7416002)(91956017)(122000001)(38100700002)(2906002)(110136005)(316002)(6506007)(71200400001)(31696002)(53546011)(64756008)(83380400001)(921005)(66476007)(6486002)(66556008)(66446008)(66946007)(86362001)(186003)(38070700005)(41300700001)(8936002)(2616005)(36756003)(76116006)(5660300002)(31686004)(26005)(478600001)(8676002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RksrWkJ6K0dBVUdHdmRWd3RXMGpkNkwzc1dYa0pzdmMxNER1V1NxR2NkZVM3?=
 =?utf-8?B?TzVZdDhuV3FsRDltNVMxYm5YS0EvUFF6dThmYTR2b3Q2NnFEbE1SM0tHZWcr?=
 =?utf-8?B?cm83dThaeWt5WDk2L3Z2SHVSQmkvUWJXMERCRzFZeTFRTzVhWXYybkNPTTJC?=
 =?utf-8?B?MWMzdnJYMER2UjJNanFDVFhqR0RYc3RHWUt6d2ZlK1lmb3czNmNiWkhuSmcz?=
 =?utf-8?B?QzhXbmZiNzYzdmYrd3NZaVJCak9OMExhcTA5bGNhRnpjM2JxQkVkSEMxeVRZ?=
 =?utf-8?B?aU5Ma1VqK25JTnQzOXZoTGVHblQxQ0FETnQ2TW5MZHR2NW5idXhabUxYQjV0?=
 =?utf-8?B?V3YwNWVPeXBFV3J1cXJEMk1BNHFvai9rSGR2UGZLUlZPSmhXMW9lTzVhZDBs?=
 =?utf-8?B?ZHJzVG5GSFNDL3E0YUc2Z245aE5Jb3kyY1N3M0g2MHVwZmdEbUhNSlhXSUhJ?=
 =?utf-8?B?QzYzRnM2dkpkazU0R3dTb3pqcWF1aUU1L3ZjemZzK0pLZzhRQllTYms4TXlG?=
 =?utf-8?B?c2RXWU9PS21sbGRwTE43TGhNMlZEb0hqNHVUWSt6d2lyQlV4TllwdHlrdzN6?=
 =?utf-8?B?SW9uNXlFcW5hNDZ0UUpBUzZuZDkya1FtNEVBR0JVdno2U1pKMkFYak03Q0Zw?=
 =?utf-8?B?WlpKbWxQSmFiZmJJL2dzOW8rdndjbFZiTm9DTW8wc3R4b2pEb2NJY2ljTDkz?=
 =?utf-8?B?VGhGaWRhS2VHM1VZMTJoaFBUditRQUxGTTZSV1owYXpJV0NwVGh5bEZROXkw?=
 =?utf-8?B?YU5EZ2RnMmdiOWw5bWlhUXF2SVRqbEJJYzdjOVFIL2xZbmQzRGJnWGNORUlV?=
 =?utf-8?B?TU1oRHRjQWNzRGVjQ0FuV2pHTVp2MlZydW5obDVSbVNWMEw3T2ZsM3d2KzBF?=
 =?utf-8?B?VGc3VGhxWGNEVTNRWUJKSDNNTG9adTdDb3QzcERkM1oxcHc3c01BSGMrbGJD?=
 =?utf-8?B?VXIyanRwWnZwZDhqN3pobGFVVDNrRnFBVUdkd3hiV2FaRU1EQ0s3V2lobUsr?=
 =?utf-8?B?ci84WDlIMzRheElnNWF0KzVlZS9LNTZGbTNOUG1SZWIvWHlpbGdUNmJJOHlK?=
 =?utf-8?B?aW1Qdk9mc1hjR0E2Q2FxaWZLVGlGZ015QU53OFJra3ducUh1SGJJUURVYzlp?=
 =?utf-8?B?cW1oRENSUUp2ZnpjRkEvcDRqNmlrT3pVOC90eEcrR2NycitZRzFxT0NzelE5?=
 =?utf-8?B?cVMzZXdIOCtkME56YW9WaWVsOGNQRW1RdGpRVnR3TWtYSEkzMjdnRFdMRkJ3?=
 =?utf-8?B?NmNRZ0d3OFVKQVlVMnJjaWNqMUFRV2dOWEhaQjFMSEw1cGlacURVK2thNGZv?=
 =?utf-8?B?Z2h1Mno0QXNkTThvTlpraC9FMGRFaHNucWhxcTEwbXcxSGZtSEVxYkZ0MDBX?=
 =?utf-8?B?bEhtSFNvWE9GSlhCeSs1OU1Hck50QS9mRmNWeHFUVDB1SThXOGlZZlZxanJW?=
 =?utf-8?B?YXllSHBidVdYbk9RUThMa1FBeU1XYzNMVlVnd0s3bGxSQlFzcHlKbU83ckRD?=
 =?utf-8?B?QjU3Rlh6ZGkzQXJhUlVBZHB4RzRMN0dWQ2xaUkVkc0E3c3VUSEdGMndWVS9C?=
 =?utf-8?B?SVU3c0lMTVJIdWxvMys4eHZzOE1kWTV4SFN1TlFoWWZDY0NOUkh0M2srRjBo?=
 =?utf-8?B?c05TdmNNSjZ2dVhvMHF4L3FMT0lmdVl6cVg3cGtsVUdPUk5RV2dydnF2aDB1?=
 =?utf-8?B?TTE1dGlxUUlIY0xhb0czOVZQb1VWMDBwTTNEU1d6eVF1OUZYY1ZXQmViQ2FP?=
 =?utf-8?B?QlJ6TlVjajNoOE1BWlcrUkZRbUlGQ1BoakdFQTZncEZmQVNYcW9pUUVoUjNp?=
 =?utf-8?B?SUVoZjZ6Z2J4clZBcTkyUWtqL0dwKytKbVNUU3MweTVzRmZ6MVdyL0VyNDI2?=
 =?utf-8?B?Q2RYSEtVYVk0NU1FVmxIYlRxWVpvNklNVmh0SXRmRmFyaGtDQ0xiMXFDSDAy?=
 =?utf-8?B?b1JkMDZpWDdCTUpROWMvWHByRzJMVHdVOGVBUSsxVno2Q3RLM3AvRnNRUmZ1?=
 =?utf-8?B?T0JPMnlnNThtRVpSNUI2d1poT0tDYzN6N3lYWElKYXk0K3lWamNRekJkbTJK?=
 =?utf-8?B?TUU1SkVwV05WZG1WaldFMkdHcEwrTkF0VGZVV0RNYXZEZnNQN0VYQU4vVks0?=
 =?utf-8?Q?V9E7U/XqKXWlPqpFXqtBX4Z/Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C48A624C5315B40831B2ED8C41F1AC8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964a03bf-b1c4-4243-d636-08da8f6d83da
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 18:36:15.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpbcNEN5Zo4GjkNPl9FIuGlxKQrzmdn1jt5aKNQJ65Yp2fiv35GvivJAuyumDSpoXoJDhwwat0TwsRBq1FnMqS4h9PSNCX/WLAbzwx/L09M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6698
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
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBCZW4gRG9va3MgPGJlbi5kb29rc0BzaWZpdmUu
Y29tPg0KPiANCj4gVGhlIGRyaXZlciBwcmludHMgb3V0IDYgbGluZXMgb24gc3RhcnR1cCwgd2hp
Y2ggY2FuIGVhc2lseSBiZSByZWRjdWVkDQo+IHRvIHR3byBsaW5lcyB3aXRob3V0IGxvc2luZyBh
bnkgaW5mb3JtYXRpb24uDQo+IA0KPiBOb3RlLCB0byBtYWtlIHRoZSB0eXBlcyB3b3JrIGJldHRl
ciwgdWludDY0X3QgaGFzIGJlZW4gcmVwbGFjZWQgd2l0aA0KPiBVTEwgdG8gbWFrZSB0aGUgdW5z
aWduZWQgbG9uZyBsb25nIG1hdGNoIHRoZSBmb3JtYXQgaW4gdGhlIHByaW50DQo+IHN0YXRlbWVu
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbiBEb29rcyA8YmVuLmRvb2tzQHNpZml2ZS5jb20+
DQoNCkhleSBab25nLA0KTWlzc2luZyB5b3VyIFNvQiBhZnRlciBCZW4ncyBoZXJlIGJ0dy4NCg0K
PiAtLS0NCj4gIGRyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hlLmMgfCAyNSArKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mvc2lmaXZlL3Np
Zml2ZV9jY2FjaGUuYyBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hlLmMNCj4gaW5k
ZXggMGUwZWI4NWM5NGQ4Li40MDFjNjdhNDg1ZTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29j
L3NpZml2ZS9zaWZpdmVfY2NhY2hlLmMNCj4gKysrIGIvZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2
ZV9jY2FjaGUuYw0KPiBAQCAtODEsMjAgKzgxLDE3IEBAIHN0YXRpYyB2b2lkIHNldHVwX3NpZml2
ZV9kZWJ1Zyh2b2lkKQ0KPiANCj4gIHN0YXRpYyB2b2lkIGNjYWNoZV9jb25maWdfcmVhZCh2b2lk
KQ0KPiAgew0KPiAtICAgICAgIHUzMiByZWd2YWwsIHZhbDsNCj4gLQ0KPiAtICAgICAgIHJlZ3Zh
bCA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9DT05GSUcpOw0KPiAtICAgICAg
IHZhbCA9IHJlZ3ZhbCAmIDB4RkY7DQo+IC0gICAgICAgcHJfaW5mbygiQ0NBQ0hFOiBOby4gb2Yg
QmFua3MgaW4gdGhlIGNhY2hlOiAlZFxuIiwgdmFsKTsNCj4gLSAgICAgICB2YWwgPSAocmVndmFs
ICYgMHhGRjAwKSA+PiA4Ow0KPiAtICAgICAgIHByX2luZm8oIkNDQUNIRTogTm8uIG9mIHdheXMg
cGVyIGJhbms6ICVkXG4iLCB2YWwpOw0KPiAtICAgICAgIHZhbCA9IChyZWd2YWwgJiAweEZGMDAw
MCkgPj4gMTY7DQo+IC0gICAgICAgcHJfaW5mbygiQ0NBQ0hFOiBTZXRzIHBlciBiYW5rOiAlbGx1
XG4iLCAodWludDY0X3QpMSA8PCB2YWwpOw0KPiAtICAgICAgIHZhbCA9IChyZWd2YWwgJiAweEZG
MDAwMDAwKSA+PiAyNDsNCj4gLSAgICAgICBwcl9pbmZvKCJDQ0FDSEU6IEJ5dGVzIHBlciBjYWNo
ZSBibG9jazogJWxsdVxuIiwgKHVpbnQ2NF90KTEgPDwgdmFsKTsNCj4gLQ0KPiAtICAgICAgIHJl
Z3ZhbCA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9XQVlFTkFCTEUpOw0KPiAt
ICAgICAgIHByX2luZm8oIkNDQUNIRTogSW5kZXggb2YgdGhlIGxhcmdlc3Qgd2F5IGVuYWJsZWQ6
ICVkXG4iLCByZWd2YWwpOw0KPiArICAgICAgIHUzMiBjZmc7DQo+ICsNCj4gKyAgICAgICBjZmcg
PSByZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfQ09ORklHKTsNCj4gKw0KPiArICAg
ICAgIHByX2luZm8oIkNDQUNIRTogJXUgYmFua3MsICV1IHdheXMsIHNldHMvYmFuaz0lbGx1LCBi
eXRlcy9ibG9jaz0lbGx1XG4iLA0KPiArICAgICAgICAgICAgICAgKGNmZyAmIDB4ZmYpLCAoY2Zn
ID4+IDgpICYgMHhmZiwNCj4gKyAgICAgICAgICAgICAgIEJJVF9VTEwoKGNmZyA+PiAxNikgJiAw
eGZmKSwNCj4gKyAgICAgICAgICAgICAgIEJJVF9VTEwoKGNmZyA+PiAyNCkgJiAweGZmKSk7DQoN
CkNvdWxkIHdlIHVzZSBkZWZpbmVzIHBsZWFzZSBmb3IgdGhlIHJlZ2lzdGVyIHNoaWZ0cyBwbGVh
c2U/DQoNCj4gKw0KPiArICAgICAgIGNmZyA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0ND
QUNIRV9XQVlFTkFCTEUpOw0KPiArICAgICAgIHByX2luZm8oIkNDQUNIRTogSW5kZXggb2YgdGhl
IGxhcmdlc3Qgd2F5IGVuYWJsZWQ6ICVkXG4iLCBjZmcpOw0KDQoldSBoZXJlIG5vPw0KVGhhbmtz
LA0KQ29ub3IuDQoNCj4gIH0NCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBzaWZpdmVfY2NhY2hlX2lkc1tdID0gew0KPiAtLQ0KPiAyLjE3LjENCj4gDQoNCg==
