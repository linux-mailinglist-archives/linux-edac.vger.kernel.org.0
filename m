Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7E5B25C9
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIHScC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIHScB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 14:32:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F14457C;
        Thu,  8 Sep 2022 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662661921; x=1694197921;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=iCGE4UkVXCojv+vwuckM71kQRFIlGCTeeoGlm9puctE=;
  b=ta01/0YuXNEHJu/5XfRoxFHV26oQlzmk/L80sYu/iKA8v/dV7i6AxNCH
   8Mc9/lj+DObCOQxAFEx3VHdsiOstrXaHDCd303nfPhAfJDaB2d62qC0rF
   CbZ8FuIYeE47Xz8DigLeYwWBFED4cqqef8JmNc48TGxlQKx/yMQ9cMJq8
   Ux4mJ6zYgrZxq/1ycWR4jMps6fv6J4l/0v0yeb12Vle8OlRjMJ8Cegsey
   uQF81yXU48n8YzseoeePUQld+xy7ShGqbghvhq7F/yUw7cIbefWZyCBCs
   Hj2BxI0ORGbMGvsIfZJLXtqc14fy8bM96zGUnn+nlkRgBaMwVGkMFbF/u
   g==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179621330"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 11:32:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 11:32:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 11:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SClFFkQRIIelPKJUySj6YBPzjyvSY4F/5A3fSSi19LdbKr+PytS//60cbrUc1pakBC4s/a1TTq59jWNjc/c7puoD/3XApll8C3KSFDAEkt/Qo85K4oUAG1ilx2OnhOE72zdzU1OJXHNfBtE481rTudU6JTR348YTKYaWd5+OFQ7PdKWi98TXj77/2KjEiPsR1WhOTRHrPCCouCr0fl72NPn+gOPjpGsiYHfLhWt7QxRIKE7GA59S+iD6rVb4YYQgywJRVAA5j+qC5W2XVhKAl1yD1Lzg3vmQG2Wzz7nUzstPPuDT8hU4D37R799o0O4aMqU96feYt9WtpH2+zPjO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCGE4UkVXCojv+vwuckM71kQRFIlGCTeeoGlm9puctE=;
 b=lcr2BUv5W/21XgnTDIE/A/e6SbRWRCcamwad4Vd5EB9A8mda/PGMJz6HbhrKp6W9YEiolzIo/ceLPlQcQURefSYlOfSUJomx+PTB5nklNVIOoIOA4iqvuCnfREcvpJPXdTFhK91zqtjtVYlZG2bRON4QQd2Dn3rY3k+nXN87V15RiYMX4cW+xkDA/jmgj6n7a3tJ1WEK2J4rADP33VngUxBeX9rnJY7Nkxoz7m1LsY+GZ+ArQSW7A7WLAFxWVKsTg0XK+vRwSy/WYC4gDH7FWAGe5gomgG4Z3sBHfscyn6P9Tx76UxLXQ4H49qTtWhZpOR+KiofoO3CJSN9yqgWRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCGE4UkVXCojv+vwuckM71kQRFIlGCTeeoGlm9puctE=;
 b=cH7lguoE1wFmIctCEg8Pwfu8yNFARJWvkNaTs5NsIC3lIew7NuA8XT+42sDAJtaAWg9PYlNIsALK4wAB1rkZeOxyVvk5j16qWhTov2wmqw+Stf6/763rtFQrknpU8r8XzHwW6bK6tT5mKL0avj0M+g/0YR859VGjKW/ysitwYmM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 18:31:57 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 18:31:57 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] soc: sifive: ccache: define the macro for the
 register shifts
Thread-Topic: [PATCH v3 6/6] soc: sifive: ccache: define the macro for the
 register shifts
Thread-Index: AQHYw5GdQ/sP9VRrjU2tIpDXDsXLg63V22qA
Date:   Thu, 8 Sep 2022 18:31:57 +0000
Message-ID: <89e804ff-b451-c56a-a256-d3917e6c34b3@microchip.com>
References: <20220908144424.4232-1-zong.li@sifive.com>
 <20220908144424.4232-7-zong.li@sifive.com>
In-Reply-To: <20220908144424.4232-7-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|SA2PR11MB5163:EE_
x-ms-office365-filtering-correlation-id: 6f799483-4715-44ec-c49f-08da91c86986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xtvxX8onyCrfTGg0ycus1jGTOAMs8M8QPnMkqCAzqMa8a2jtrasWlrOcy6ilbXhyxkZPkfLCgcet6pNGubdFd7+SrvcNI1RdVnD6deU/Y0W2FTVmbTqHpjoW9+VVc0KGf9FnCmKwOpVN/mQeEmJIT2bcjhdrdTp2rE8Zv7ftXe/lk5U1zHy1agtqNzgr7dFlhgc54WWjxRphJ4GSlrQliQK3vzlsr0rQPbkgu9oDn4KItFKNVAccyxRlWCBnsrZ1u87gUBd1gk4aV2i4yfTSrZ69y+60wF6Rd4xKGid03zH1XoBB3PKQqiwsH3g/ugtodkBjxDb1Ut+UbsCtwms3XYTt5IyQC4p46MkTgcZbvGZ70m0z4VNCyRSVRXM+/Zov1t2OlmTFn5J+vIZG/6TsQSBHKlWvERCnH0Xep0F2IpAp2FZdPdE/czYA6dt7yxBgLlofC77HU33QD3kngw4eddsC+vJfjAgCZpto6iL/W0JbGoM2WZBhXzvQeP7Yd21jRtNjrmYrkFTtycPyr+YMU0zpMFPN1qkAU/eB1xUWWEuza6iuxF8C+7opO1QSpnf+ppBPsIONi/etglqcmsiep85F4RmS7Wb+1VYiB64OS1GirycOB3deGCk0ZJw38gDuaCV87hAHCLFPRqWg7Ro9ahfRP91HQHKpj2rYHGu8A5dCpDYI5nfKAjw3VZhRdq8ty7KO1iOjN8S4x5+qrjRRBRopjW7qxey7amGMAzP8kv4T694e1bVvyX0LEiy5wLFU82PTs/64KCTUyzSJGJhA8k7HNzZ8YOKubkZdZSEB5kU8DAm/W/z7+F3jUOHRZCBC9tfnuoUaQmkvFFiAEgpss+K96zQQe1uVEwutRRJJTU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(396003)(366004)(346002)(6512007)(36756003)(66946007)(8676002)(91956017)(66556008)(76116006)(66446008)(31696002)(86362001)(921005)(316002)(64756008)(41300700001)(38070700005)(53546011)(83380400001)(6506007)(38100700002)(110136005)(26005)(186003)(508600001)(66476007)(122000001)(71200400001)(8936002)(2906002)(7416002)(31686004)(6486002)(5660300002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm1pbjZNdzVGMXBIWE9ZTDFqKzB1dFRTVFNjbmlCdlRHTU5QaWpWaVpYS3lt?=
 =?utf-8?B?dUZhbmVaYXVKM2xzSENhTFdiVk9IUlBBMUoyK2U2Um04NnlHMktITlJ1UVl2?=
 =?utf-8?B?RWhWN0ZXSUZYRVRUNVMzSXgzUE5UK3UwRGhiOTdiRGlpWS9YeWhzQWpCUjN5?=
 =?utf-8?B?Q1U2aGZWSkljRVpSbUIvbzUwZlViVGcrS2Nrc210SG5MWXJEbG9RUndWcXhF?=
 =?utf-8?B?Vk9XcktEaVlXWHFKZXREVUdNTFpLU0R1Y2tiVmIzOGNLU2Q5NEZWajZXa0hV?=
 =?utf-8?B?L0RPV1FwZ0FIaEJIY3ZTWnp3QzYydlpIbm95K0UxdWF5L2VNM3g5cXhObXZx?=
 =?utf-8?B?NEVlQndSZitHT0JmK1BOS09DN3FxNjl6NGJMcFViRU9zTzZHeDB4bm11c2U4?=
 =?utf-8?B?Y2tGTCtLSUYrVUNSdXhxaTk4WjB0RGgycUtyWGdCRUlaNmIwRGwxS3NLejNM?=
 =?utf-8?B?RjlHQlVVTUEyTnJFYXZqZWs1WkVTbTVCMjEzaW1lcWtyWi9GcTBYTWhQWE1y?=
 =?utf-8?B?b1lOQ215U0RZOFdvMmdpSGtpdDBOS005NVJ2bFVKTmIybnJ6eW8rcHJTaG8x?=
 =?utf-8?B?WlNLbmJNRWlRQlRzemZnU1FZOWRPK1FjUXVZOG5UdTJwZzhuMFBKWk1hQUky?=
 =?utf-8?B?dDJOMGo4TXhpOSs2U1lWa0k2Z3RHZXN1WHRXemZpR0VHdkdDZFZoYmpJMWVY?=
 =?utf-8?B?d0ViWkFNaXBYTVZaT2tvOExHZWtGcEdjRzhPWHh4cTAxMjVvaHNkUW5oY3pt?=
 =?utf-8?B?MkZ5YWNzb2h4dmxodWtaVmFJUGFXQ3lQZTZteEZDVzZMeGxsMGJFMStYOW9o?=
 =?utf-8?B?WnVGRzdvZEo3UDdWVDlTSHlNaXJYSW1hSzQzd20xSFNSQmpjMjlIWmVmR2Zm?=
 =?utf-8?B?YWtwTDR2K050QjhiU0FuNExoMWJ3ZW5WL1pyNVVrQUlZSU05OEdKcENFWTVk?=
 =?utf-8?B?ZmNWTC9jSkU2RWVWdHFubFpEWkwwOUllS0NhV1NmSnN6cE55cklzMFcxSGhT?=
 =?utf-8?B?NiszdHcxOW11Y3dqN0NvUGs1bVQxaEdpQ0VwSUNDMUVMRHMvQXNXT2R1THRR?=
 =?utf-8?B?eGJBeFRZTERFcTVOOFZibHdWSkgvNlZSMVhOcGFuUHg4bVU1WnlNWkR4TlU4?=
 =?utf-8?B?aEwxZ3BHTEJlM1MycUhlN2xvMDBzRHpRTHdrL3NWODF6dmRmUEkrUXpwZExL?=
 =?utf-8?B?QWZ3QXZjRGdmM1N2ejJ5SHBjVVVURG82M2VKVXlUeEF5ZFo3L2lrc2dIbVAr?=
 =?utf-8?B?QmdNZ3J4Y1hEcFVsUjdCUWZJemQ2NFIvT3FRTjhUcXg5WmcrcG9OVXFaQUhu?=
 =?utf-8?B?S0RkQmhPMUo5VlZwU1hKdDJGejdNV01NU0RadUQxdVVSYTBsZUdkT25WVWJD?=
 =?utf-8?B?bVVQdGkvTnd0RUJjT1VGcVRRUit5elcyYTZhcUYzZC9EaTZCWmR6Z0lJNnVM?=
 =?utf-8?B?bWg1azFrSUgwbEpvMEN6eitVU2FBOUgyTnlvZmtCVis5Z0NWYjFFQzhzU1hn?=
 =?utf-8?B?ZHFMS3FmcFAxTmVtc3FndXNxcWh3bDZPdis5WEFrNG01R0JGK09tV3Q4QitK?=
 =?utf-8?B?UUw3Q3R5VUc0Zm9hTjFQT1JlSW9ub3p4dUVXUW5JZTlNYzJWZnNSUncrMkln?=
 =?utf-8?B?NVRUM1h6Z3lKNUU5ZS9EdWlMQjRER0taLzlrOEs3WmJzQy9zdDNEbXhYTFlG?=
 =?utf-8?B?M0Q5Z3YrVWMzMHRQK2FsbGNTKzhtSTJZS255bFlScFc4cWdpenNvbFdTTWR3?=
 =?utf-8?B?ZmRaVC9EbEExaFlnNkQ3czh6VUpkNVNDc2dUSDZVRFVUbFBtQ2RDcVFHbjVF?=
 =?utf-8?B?SzIvLzdhWDZ2Sm9DZVFQNEFVOEdralhPalk5bEMzQ3FxUmliZ1BVVlh3VkJT?=
 =?utf-8?B?QUQ1MlhwQ3NkRVQ3Q011b0JYK2Q2UjZwdTVDekdzWWpqaEQvZEZJaU12TmxO?=
 =?utf-8?B?QjE4dG9mcTFIUFVCYXlscEhEb01yZmtzaDgyY3pEeERoc0lvdU4rM3RmZzBz?=
 =?utf-8?B?N3BPM0hMQlh5K1hJTUMxVityLzVVRStza29FMHh2eEs5WFJDQzgzMkx1ZnVR?=
 =?utf-8?B?eXAwWDRkMHROMGZxb0JPYVRFSFYvZmZRYm13R0VRUXZPOEpBbTZUNVVnaHFn?=
 =?utf-8?B?NkRTc1JHbXRrdk9IUUtyR2NKMDl5Zld1SFI1RkljOVhlNEttN2FMZE1kclVU?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A7469996A794C4589C40870C4EF8BCF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f799483-4715-44ec-c49f-08da91c86986
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 18:31:57.5960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoAAAGr1LClYkfV1ojcQu7bhPX2icBDDHtGbMlIu5liZHe475jXldfp0OAWXKgYJDPvdEqQKBTur/NnvSAhnRdn0o7l/JYdoUmgZCZjKIE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5163
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
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBEZWZpbmUgdGhlIG1hY3JvIGZvciB0aGUgcmVnaXN0ZXIg
c2hpZnRzLCBpdCBjb3VsZCBtYWtlIHRoZSBjb2RlIGJlDQo+IG1vcmUgcmVhZGFibGUNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFpvbmcgTGkgPHpvbmcubGlAc2lmaXZlLmNvbT4NCg0KQWhoIG15IGJh
ZCwgSSBkaWRuJ3QgcmVhbGlzZSB5b3Ugc3BsaXQgaXQgaW50byBhbm90aGVyIHBhdGNoIC0gc29y
cnkuDQoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAu
Y29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2ZV9jY2FjaGUuYyB8IDE2
ICsrKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZp
dmVfY2NhY2hlLmMgYi9kcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2NjYWNoZS5jDQo+IGluZGV4
IGIzOTI5YzRkNmQ1Yi4uMGRkY2M2NTdjNjk0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9z
aWZpdmUvc2lmaXZlX2NjYWNoZS5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVf
Y2NhY2hlLmMNCj4gQEAgLTEzLDYgKzEzLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9vZl9pcnEu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
ZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gICNpbmNsdWRlIDxh
c20vY2FjaGVpbmZvLmg+DQo+ICAjaW5jbHVkZSA8c29jL3NpZml2ZS9zaWZpdmVfY2NhY2hlLmg+
DQo+IA0KPiBAQCAtMzMsNiArMzQsMTEgQEANCj4gICNkZWZpbmUgU0lGSVZFX0NDQUNIRV9EQVRF
Q0NGQUlMX0NPVU5UIDB4MTY4DQo+IA0KPiAgI2RlZmluZSBTSUZJVkVfQ0NBQ0hFX0NPTkZJRyAw
eDAwDQo+ICsjZGVmaW5lIFNJRklWRV9DQ0FDSEVfQ09ORklHX0JBTktfTUFTSyBHRU5NQVNLX1VM
TCg3LCAwKQ0KPiArI2RlZmluZSBTSUZJVkVfQ0NBQ0hFX0NPTkZJR19XQVlTX01BU0sgR0VOTUFT
S19VTEwoMTUsIDgpDQo+ICsjZGVmaW5lIFNJRklWRV9DQ0FDSEVfQ09ORklHX1NFVFNfTUFTSyBH
RU5NQVNLX1VMTCgyMywgMTYpDQo+ICsjZGVmaW5lIFNJRklWRV9DQ0FDSEVfQ09ORklHX0JMS1Nf
TUFTSyBHRU5NQVNLX1VMTCgzMSwgMjQpDQo+ICsNCj4gICNkZWZpbmUgU0lGSVZFX0NDQUNIRV9X
QVlFTkFCTEUgMHgwOA0KPiAgI2RlZmluZSBTSUZJVkVfQ0NBQ0hFX0VDQ0lOSkVDVEVSUiAweDQw
DQo+IA0KPiBAQCAtODcsMTEgKzkzLDExIEBAIHN0YXRpYyB2b2lkIGNjYWNoZV9jb25maWdfcmVh
ZCh2b2lkKQ0KPiAgICAgICAgIHUzMiBjZmc7DQo+IA0KPiAgICAgICAgIGNmZyA9IHJlYWRsKGNj
YWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9DT05GSUcpOw0KPiAtDQo+IC0gICAgICAgcHJfaW5m
bygiJXUgYmFua3MsICV1IHdheXMsIHNldHMvYmFuaz0lbGx1LCBieXRlcy9ibG9jaz0lbGx1XG4i
LA0KPiAtICAgICAgICAgICAgICAgKGNmZyAmIDB4ZmYpLCAoY2ZnID4+IDgpICYgMHhmZiwNCj4g
LSAgICAgICAgICAgICAgIEJJVF9VTEwoKGNmZyA+PiAxNikgJiAweGZmKSwNCj4gLSAgICAgICAg
ICAgICAgIEJJVF9VTEwoKGNmZyA+PiAyNCkgJiAweGZmKSk7DQo+ICsgICAgICAgcHJfaW5mbygi
JWxsdSBiYW5rcywgJWxsdSB3YXlzLCBzZXRzL2Jhbms9JWxsdSwgYnl0ZXMvYmxvY2s9JWxsdVxu
IiwNCj4gKyAgICAgICAgICAgICAgIEZJRUxEX0dFVChTSUZJVkVfQ0NBQ0hFX0NPTkZJR19CQU5L
X01BU0ssIGNmZyksDQo+ICsgICAgICAgICAgICAgICBGSUVMRF9HRVQoU0lGSVZFX0NDQUNIRV9D
T05GSUdfV0FZU19NQVNLLCBjZmcpLA0KPiArICAgICAgICAgICAgICAgQklUX1VMTChGSUVMRF9H
RVQoU0lGSVZFX0NDQUNIRV9DT05GSUdfU0VUU19NQVNLLCBjZmcpKSwNCj4gKyAgICAgICAgICAg
ICAgIEJJVF9VTEwoRklFTERfR0VUKFNJRklWRV9DQ0FDSEVfQ09ORklHX0JMS1NfTUFTSywgY2Zn
KSkpOw0KPiANCj4gICAgICAgICBjZmcgPSByZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FD
SEVfV0FZRU5BQkxFKTsNCj4gICAgICAgICBwcl9pbmZvKCJJbmRleCBvZiB0aGUgbGFyZ2VzdCB3
YXkgZW5hYmxlZDogJXVcbiIsIGNmZyk7DQo+IC0tDQo+IDIuMTcuMQ0KPiANCg0K
