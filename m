Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163835B6BB3
	for <lists+linux-edac@lfdr.de>; Tue, 13 Sep 2022 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiIMKew (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Sep 2022 06:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIMKev (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Sep 2022 06:34:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E90EDF2E;
        Tue, 13 Sep 2022 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663065290; x=1694601290;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=J+WLZw9Unp5mpPuI6+FtUJhTxizVpF0ecfb0wRSQ9t4=;
  b=aGHz6GAZEfHIpkn2RVGRAXw3IBhhPa4qQdiH0v8BPlJCQ2I8+wzNx4Dt
   Gamh+c7fEu8bMgGVeqSQVYM6gmZi7Bca2YcOx3LcK0b4PT2+Rnul/8EF6
   ORU/LEvPXO3tHtF0dzsTZr1W28+9ZI55sHISUiU12W9zmfDDP8sGiECbA
   DJ++Z5Ldn2Jtn8Q0V3GhfEsoGiyC01GRACYExlNKpZznCai/bwiqgyWkY
   LmdKH/uDpb5yXCNfF7LLNTXZlYfFtaelawmARSE9gz8PJPDYGLgF9o+Xi
   36fvKOBILOy9uSTqtnBQbxIUSzwtvSXED9KosfOjeRQHuE0DxkbisSxbZ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="173604332"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 03:34:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 03:34:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 13 Sep 2022 03:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co6zuYPCCBEVK7kEvZaEe6tcVnYaXmYJwhH1Jigy+Iys/IPldzWqeooefl2j8OFiJxIsvHkSBZuWqmZ/+mjO9XcapJLlhhedTUmO48o49s7JVqTLQnmLJLyrbZrHQi1e73KR2m3I/uZPIOYCxPKQR67novkEQ588rlK5dsDBZsqg/yU5E5jmykUeTuI0VuPGmvryBk1DaiUZ+o96EsAlkgL0O+AAajkTo9VXEi4HWfcfMBFY9Ji0Jgj2xntoSXCj0kJSB5cAmUpkj+Q8tY4La0gQ60nzYVTLKU+ftFMGNzte0qd37+PAS0JjWY7Jufz3VJk3TDljyOHncFm9ZGNP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+WLZw9Unp5mpPuI6+FtUJhTxizVpF0ecfb0wRSQ9t4=;
 b=QIK0vMJTWg6IqpjPyCzkPez0In7X4WZz0keRwbTm/Kd1TTecOO1i+6T3RHFcLqU3iw213OxOh+b8dniOv6kKRqcPFRPZM890NygOBkqPbrxbgbBbggYArWWws7TSyjAtXe+04kdLlr5Ek1GQsbFKaofrfDPzJMO4zR7+PsQ2CGBaUOA6Wpt6nUkE2ofQk3TMGXMTziaSqexvzVpAwJyyFMWyMwWLxTmx+ZlbHYHbIBkvP1zm3P3kPGnG7/151rdGqMp5Y+kZ/tfkhFi3t6QCO7Bs5iHTuJCb0a25e2G2VPn3SkdkBoaB5xMgHOxnY6eNCJ54MQEO8z8CDrzT91bCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+WLZw9Unp5mpPuI6+FtUJhTxizVpF0ecfb0wRSQ9t4=;
 b=PWrQ6VC+RDojXvvUxxK4kS8EwdKzjuDlLlOql/LtEStieJuvHHIGlLVwMBiWZkRl09Ju6DFMunX5V7DBIz1zOjX4FcIO1J9DE0eyp6W+3qc8rAl1B0szU6KL2uFumJtxdnhpcD1MJMYA+1wJiYhiWqFr54XgLzZUQes/1qPpArY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 10:34:44 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 10:34:44 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 7/7] riscv: Add cache information in AUX vector
Thread-Topic: [PATCH v5 7/7] riscv: Add cache information in AUX vector
Thread-Index: AQHYxzi8Jbge1xGIPUuqsebcZoFnIK3dKm4A
Date:   Tue, 13 Sep 2022 10:34:44 +0000
Message-ID: <88298aa6-6786-12a7-8559-2b49ee1081e2@microchip.com>
References: <20220913061817.22564-1-zong.li@sifive.com>
 <20220913061817.22564-8-zong.li@sifive.com>
In-Reply-To: <20220913061817.22564-8-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|BN9PR11MB5307:EE_
x-ms-office365-filtering-correlation-id: e32348c3-b024-4c01-965e-08da957392fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hUJdaXll1VtSIcYcmllwa2QANUyz98ePpHCPQO/MGJkaaP2YeC8yO9erT44XzfJIwKJrg8E7vlWSjN7vBCaaPOA9pojbwwz465V4NXDi+htsdLE8c+jqLW0/EX+raEdiYKcNPO+p146IV9bKe61RuECOFiwhCFwmNACCnAgbUj6VFk5y9eejNSA1fNQlaUzh9UZMbW0r2V+fpcI/fR/0+b7Y3Tn+NEJ1UffISo4nu6tw80nBZXa3Srt8VfJTNpSd/5XOsgKWKbuPMtHbdoKWUj/CO96p4Gl1DjS3Q4ljF+4hdoNZgecMZo1P2Y8dzimi61J6KtzJ1qoSu/5sIUn8PMRnZam+Dd5f3SP/8QkY0DV0liRkPlnTaAhTaafZMo5vPBhg8BwAYhgCbH5ttDeXgNktoa75cPwE1qcnaCJ6bVpHSED3npfIAuY46JYU7YOzCmIBleO60NBikiYY6N2ML4CtXtDA2s2r4mKJ4wRnj9RnOaxKtV/qPMPtATeHpP6dWE75RnV7H9Dt9sw2hpe34HkwYNsR3uijpTSFT5Fk0eBr3qq/CRE/rnYMaFK4UoD/C8Ltt436oybhGyMxoFTKnpu7TUkPQIN6E/IJx2G/3Ml2k+KJ0NDUnNSVFQxZCH/NPnjvcs+sVBRqQxCxSMLHP15lBtTJciXGdQIyq+woE7Aaom3pzmYOrIcA5dhHpMzY/AD7C4YpCHvN091BKSyoMgpWWuYKudBF2+T0iV+mlwV2csFqg7ANqGkyH5takJICdmWgbnPG9U74uVLxzHQRU8WbpA/hzjfFPUpCQxkp7DMmJVks4jbtvgZj4HWhnALYwiHFkuV/46DAM/Gm6ZGvSfW/HZsSTZnC3GgHQY5JXkewKJblZ6BjiewSb515ce+s0nPtheNTUe3hPMi+wrya5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(66946007)(316002)(110136005)(66476007)(64756008)(66446008)(26005)(6506007)(31686004)(6512007)(38100700002)(91956017)(36756003)(8936002)(5660300002)(8676002)(2906002)(122000001)(31696002)(76116006)(86362001)(83380400001)(38070700005)(53546011)(186003)(921005)(71200400001)(66556008)(6486002)(41300700001)(478600001)(2616005)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDdKNkIyQ2oyN2FMdUNpZC83R1ZYN29NckRya1ZsZ1Nyem9BQTJjeTJxNUpM?=
 =?utf-8?B?WmRsdWRRNkN6cHJ4bys0YmJCK2M5QkNJLzRCUkhZTk56WW52NXZTb0RJR0JD?=
 =?utf-8?B?dDBtS1hTY0MzTGxyZVRJbytZa0VLcndkc3JRaHRjU3I4RlA2L2MxayttM1RK?=
 =?utf-8?B?WTdkbGtHdkNKdW4wemVwaXFoWk5teWw2K2xhYUw5ZndzSjNzSHhHM1BnTGJW?=
 =?utf-8?B?TjVMQ0NJNFVwTTdpa2VmbndLT2crZU1XTlRadEYwNDhheER4U25jdzRkWjgv?=
 =?utf-8?B?em5tWWFyM1RieSs3SVVUS3NhQzcwQU9LSEpTWFM1ajhUYTAvaVo3dmhQN2xX?=
 =?utf-8?B?SmlYSiswYmRNOXpQR2kwYjVvVTg3SzVTWG94WExsUldDTm03SXhYU01qTzN6?=
 =?utf-8?B?Y0JMOEpieGVtTDVFZjd5eE52NTJ5TVpXRVB5d0tJRTVhTjFxSDl2dzl4ci8y?=
 =?utf-8?B?ODl3S3FlcE0wWHM4RUxHTzEzeGdORmY2WXI5YXYzelB3c2tlWXpMVEtKSzhu?=
 =?utf-8?B?M09ValdMM2hBMDRHeVNMd1k1ZnJ6cml0OVpwdHhtaXpSTlNON0FnM0lvaXRm?=
 =?utf-8?B?aCsrYTRYNlNpQ1J6Ui9HaGZ0dEk2RXoxWXRQajNYUmUycEpKTm5EMDEwUTZI?=
 =?utf-8?B?UE50Y0x4djRyWWpXdi9WQUx3dEJSUlAveGVZVGNjTUk3Q2lnWllwRDczeUtT?=
 =?utf-8?B?OGhXVFAyTGt2ay8rNUVIOWw0V281SE5qcG9rQk5GOWJnMDI0Q080L0FoT0Vp?=
 =?utf-8?B?cWlyWWxCUUZJTHZRd05aa1JTV1VtMlkrVkVyVEJRbXUwcGhLOHN0QmZWWnQr?=
 =?utf-8?B?Zy9nUXB3em9YMkRZMHozQzRwUmdYR25GS3QrNnhIK1ZjYzZRSUk2d1ZYU0M5?=
 =?utf-8?B?ZTNic0hpUlZBRURPT1NyL0JkQzZTejBqenZROU82N0VtWUs0aTUvWG4vTVVn?=
 =?utf-8?B?WE5GM0VFcCtsUDNsR3E4M213aWVhU05yWGFLQ0hWMmZBTitzaEozNmRUc3dZ?=
 =?utf-8?B?Q0thNWp2QnBENDNnQm5aN3RjUEo1RGlEQ01RMEpOYmFLTHNhaUh5c3J1YmhM?=
 =?utf-8?B?NWJKMDcyTXNVb0tGSXBJQ0daUVc0aUlBWUFkZDB5RFNKMDZ3N2ZOeURDS0dF?=
 =?utf-8?B?OVVCb2tXakxKWmpiUWlqZlQ3Q3BMNnI1ZGZNdGNwQk9SMERsSHZiWng2alpp?=
 =?utf-8?B?bWZ1ZkZmSVBIOXF5UitlbFl0K3BBc3FRbEZVeHlIbUxqczFCdGZkUjB1ZzhP?=
 =?utf-8?B?cTJKR3Z6Q0MwMnFaTnZweC90U3Bjano2N0Z4cnlqcUhZTm5PR25XNDA2Q1p2?=
 =?utf-8?B?SWloSFlOWG9jSGplYzlQalVmdDl2T1dhWFJ2T2JHeVdlU2FFYzlCUXNwSmt6?=
 =?utf-8?B?bmZpMm1hd3N4Vi9QeEdZL3o1cTgxUlZRNkNab0tMUTBiVGJieUttTEVldWRm?=
 =?utf-8?B?cnhnRTVRaE54LzlUb1hhc2tyak1qOUwxazNKTzdrVUdTdFJYb0xyZlhoeith?=
 =?utf-8?B?QzRBS2o5Y0RQdGZtOVNyc0JldGxLcFM0TlRvYXpId01EN3lWTWRqT055NHdM?=
 =?utf-8?B?TkZYaVV1dUR4Ni9xQ1VUU2FQQThFcnlpL00yVkpyTTlXeUlabnR4VEFnUzF2?=
 =?utf-8?B?WHBOYlcyNmVvaDRVNU5rc0ZWN3J4cVgzOWZ3Q3hiTTErd0gxSE1OZHdkTGkx?=
 =?utf-8?B?YXNHelI5MWh4N2IreDhvYmxONFdRc08xMGxwdGVLZC93RS9zY2N5VGloM1BM?=
 =?utf-8?B?NHRyejVOYWgzWjJ3cjVYdGpEaG9QdEc5TktnQ0VMWDYvVVI2Sk1VMjgzTXd2?=
 =?utf-8?B?bWt3eEs3MlVCTDIwOFNhMWpwNDI4V3hFZnZxL3E5dEtzVEhPekI1ZVQ0c2ls?=
 =?utf-8?B?cXZVcFVCTmNZN0VNYXM4VW5rWnlORUp6RVpJNnJjNVRWYnBKM0djMGdkRGxh?=
 =?utf-8?B?NWVCeEtuMEY3dEJ5aWExZGZCVG1KaFpuRC8zZzdlMHlTaWdtZkZ6SXEyNFA3?=
 =?utf-8?B?TnRVMk43Ti9iMEtTVzEycjJka2xRVWhPZjR5cWVFakpRWW00Ly85VlBxbGND?=
 =?utf-8?B?TlE0QXNKNXBoa01pY05LWUVyUzhaZE9zNzlaTnZDTnJyNDBTZWZXSUM1MURs?=
 =?utf-8?B?OVNZajV4MXVCZmgzOXVZS2xpRjZGUDhLRzMyeWFXOWowcDJvcUhHK3d6V1lu?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <353FC3D00A53AF4F95C29B00C3C38B17@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32348c3-b024-4c01-965e-08da957392fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 10:34:44.5813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50YK+U/t/hp6lyNCsW+gCumB1GV0pTjFVdLHl4Tq7EiyYLiFmoKylsgzgM8S+4mQq9KztaMeP/WRkDIXJHVDlP4EdTV88hNMAPrP+5BnBfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMTMvMDkvMjAyMiAwNzoxOCwgWm9uZyBMaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBHcmVlbnRpbWUgSHUgPGdyZWVudGltZS5odUBz
aWZpdmUuY29tPg0KPiANCj4gVGhlcmUgYXJlIG5vIHN0YW5kYXJkIENTUiByZWdpc3RlcnMgdG8g
cHJvdmlkZSBjYWNoZSBpbmZvcm1hdGlvbiwgdGhlDQo+IHdheSBmb3IgUklTQy1WIGlzIHRvIGdl
dCB0aGlzIGluZm9ybWF0aW9uIGZyb20gRFQuIHN5c2NvbmYgc3lzY2FsbA0KPiBjb3VsZCB1c2Ug
dGhlbSB0byBnZXQgaW5mb3JtYXRpb24gb2YgY2FjaGUgdGhyb3VnaCBBVVggdmVjdG9yLg0KPiAN
Cj4gVGhlIHJlc3VsdCBvZiAnZ2V0Y29uZiAtYXxncmVwIC1pIGNhY2hlJyBhcyBmb2xsb3dzOg0K
PiBMRVZFTDFfSUNBQ0hFX1NJWkUgICAgICAgICAgICAgICAgIDMyNzY4DQo+IExFVkVMMV9JQ0FD
SEVfQVNTT0MgICAgICAgICAgICAgICAgMg0KPiBMRVZFTDFfSUNBQ0hFX0xJTkVTSVpFICAgICAg
ICAgICAgIDY0DQo+IExFVkVMMV9EQ0FDSEVfU0laRSAgICAgICAgICAgICAgICAgMzI3NjgNCj4g
TEVWRUwxX0RDQUNIRV9BU1NPQyAgICAgICAgICAgICAgICA0DQo+IExFVkVMMV9EQ0FDSEVfTElO
RVNJWkUgICAgICAgICAgICAgNjQNCj4gTEVWRUwyX0NBQ0hFX1NJWkUgICAgICAgICAgICAgICAg
ICA1MjQyODgNCj4gTEVWRUwyX0NBQ0hFX0FTU09DICAgICAgICAgICAgICAgICA4DQo+IExFVkVM
Ml9DQUNIRV9MSU5FU0laRSAgICAgICAgICAgICAgNjQNCj4gTEVWRUwzX0NBQ0hFX1NJWkUgICAg
ICAgICAgICAgICAgICA0MTk0MzA0DQo+IExFVkVMM19DQUNIRV9BU1NPQyAgICAgICAgICAgICAg
ICAgMTYNCj4gTEVWRUwzX0NBQ0hFX0xJTkVTSVpFICAgICAgICAgICAgICA2NA0KPiBMRVZFTDRf
Q0FDSEVfU0laRSAgICAgICAgICAgICAgICAgIDANCj4gTEVWRUw0X0NBQ0hFX0FTU09DICAgICAg
ICAgICAgICAgICAwDQo+IExFVkVMNF9DQUNIRV9MSU5FU0laRSAgICAgICAgICAgICAgMA0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogR3JlZW50aW1lIEh1IDxncmVlbnRpbWUuaHVAc2lmaXZlLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogWm9uZyBMaSA8em9uZy5saUBzaWZpdmUuY29tPg0KPiBTdWdnZXN0
ZWQtYnk6IFpvbmcgTGkgPHpvbmcubGlAc2lmaXZlLmNvbT4NCj4gLS0tDQoNClRoaXMgX2xvb2tz
XyBjb21wbGV0ZWx5IHNhbmUgdG8gbWUsIGJ1dCBpdCBpcyB3ZWxsIGJleW9uZCBteQ0KcGF5Z3Jh
ZGUuLi4gRldJVzoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNy
b2NoaXAuY29tPg0KDQo+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9lbGYuaCAgICAgICAgIHwg
NCArKysrDQo+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL3VhcGkvYXNtL2F1eHZlYy5oIHwgNCArKyst
DQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2VsZi5oIGIvYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS9lbGYuaA0KPiBpbmRleCAxNGZjNzM0MjQ5MGIuLmU3YWNmZmRmMjFkMiAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9lbGYuaA0KPiArKysgYi9hcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL2VsZi5oDQo+IEBAIC05OSw2ICs5OSwxMCBAQCBkbyB7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAg
ICAgICAgICAgICAgICAgIGdldF9jYWNoZV9zaXplKDIsIENBQ0hFX1RZUEVfVU5JRklFRCkpOyAg
ICAgICAgIFwNCj4gICAgICAgICAgTkVXX0FVWF9FTlQoQVRfTDJfQ0FDSEVHRU9NRVRSWSwgICAg
ICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgICAgICAgICAgZ2V0X2NhY2hlX2dlb21l
dHJ5KDIsIENBQ0hFX1RZUEVfVU5JRklFRCkpOyAgICAgXA0KPiArICAgICAgIE5FV19BVVhfRU5U
KEFUX0wzX0NBQ0hFU0laRSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAg
ICAgICAgICAgZ2V0X2NhY2hlX3NpemUoMywgQ0FDSEVfVFlQRV9VTklGSUVEKSk7ICAgICAgICAg
XA0KPiArICAgICAgIE5FV19BVVhfRU5UKEFUX0wzX0NBQ0hFR0VPTUVUUlksICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPiArICAgICAgICAgICAgICAgZ2V0X2NhY2hlX2dlb21ldHJ5KDMsIENB
Q0hFX1RZUEVfVU5JRklFRCkpOyAgICAgXA0KPiAgIH0gd2hpbGUgKDApDQo+ICAgI2RlZmluZSBB
UkNIX0hBU19TRVRVUF9BRERJVElPTkFMX1BBR0VTDQo+ICAgc3RydWN0IGxpbnV4X2JpbnBybTsN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS91YXBpL2FzbS9hdXh2ZWMuaCBiL2Fy
Y2gvcmlzY3YvaW5jbHVkZS91YXBpL2FzbS9hdXh2ZWMuaA0KPiBpbmRleCAzMmM3M2JhMWQ1MzEu
LmZiMTg3YTMzY2U1OCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL3VhcGkvYXNt
L2F1eHZlYy5oDQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS91YXBpL2FzbS9hdXh2ZWMuaA0K
PiBAQCAtMzAsOCArMzAsMTAgQEANCj4gICAjZGVmaW5lIEFUX0wxRF9DQUNIRUdFT01FVFJZICAg
NDMNCj4gICAjZGVmaW5lIEFUX0wyX0NBQ0hFU0laRSAgICAgICAgICAgICAgICA0NA0KPiAgICNk
ZWZpbmUgQVRfTDJfQ0FDSEVHRU9NRVRSWSAgICA0NQ0KPiArI2RlZmluZSBBVF9MM19DQUNIRVNJ
WkUgICAgICAgICAgICAgICAgNDYNCj4gKyNkZWZpbmUgQVRfTDNfQ0FDSEVHRU9NRVRSWSAgICA0
Nw0KPiANCj4gICAvKiBlbnRyaWVzIGluIEFSQ0hfRExJTkZPICovDQo+IC0jZGVmaW5lIEFUX1ZF
Q1RPUl9TSVpFX0FSQ0ggICAgNw0KPiArI2RlZmluZSBBVF9WRUNUT1JfU0laRV9BUkNIICAgIDkN
Cj4gDQo+ICAgI2VuZGlmIC8qIF9VQVBJX0FTTV9SSVNDVl9BVVhWRUNfSCAqLw0KPiAtLQ0KPiAy
LjE3LjENCj4gDQoNCg==
