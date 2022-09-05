Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E1A5AD926
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 20:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiIESo4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 14:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIESoz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 14:44:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197621AF1F;
        Mon,  5 Sep 2022 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662403495; x=1693939495;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ZCsB/lVFWfGhXiV0l4jtmoYyz74PN1Ez1rQQdMCMYfM=;
  b=k5E6PkRTdnZ2d3IjE0I/1Ng8IjMRb61Pqr2eWjMSZ9/Vbt/TNq2ntrJU
   Sy26BBfUceS8e04o+6d5QebzYjHUSHDXc/MF9U6SxXQGUIhrlqLyI6hBn
   SzRoT9XODRngL3Y3GG//3jwHsutfJV4dtgHZnAlZXoNAzFBDUM/4LjDwk
   p2OdzBV9LMQqzTaJk+UAO4H526toAJwqG4j+KS2Pgzja+KB08TTRqEJP/
   0/AAwrorOBKnMSUDac5yLoY/NSG31bDBL+bivSe5B3RT9L+iOnXOSLf22
   X6DK52tlTCrhUlfjqkRTl6WIpwhNKyW1dC4Q5me3tT7OA8QLDHZQWFVgT
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="179245551"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 11:44:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 11:44:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Sep 2022 11:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb+ILuILTyNpqY5p00bEq7Z75U8qmt9Mz2uyAwiRGC4ELcWO3QLBGOSuBNPMN1UaaWMm0dJkrM8dik/MGdwC1OLoDS2cih5iO2UCGAaQvy3zHVBb9+/7gnBUd2ohABiRoMQMY17wajFpGJsCtHgF6PUn66DCp+UhGrDfFo8ngQ5aNc3GUix3L7UhNxw4AKyjjd/9rJ2ianeAUN2YNP2U7mjS8hWFAdW7AEj4CAZQggG5BkLKbuhVnaJGkLemIrp+eHJs9WyIXHr/+xKYz8mygRFRSihG2sIhYLQzwIuJgyaOKs7B/0pLqYyCnFXwcgmyF/wWSUXYxNIdqo+CtlTMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCsB/lVFWfGhXiV0l4jtmoYyz74PN1Ez1rQQdMCMYfM=;
 b=ObI6Rvy+ZxQmGnnv7MQB6G/7fDxd1jynpHJnWwPhPyDXRk4qobenIU3CZr8TOZqhen2HfDMbI6CzOrcr0zixePdoZMbs9MuejFQizJ63wdG/pIP/CFmUE4/IFz7DbneSWNreTfjVVHS5VpbN3HIwczCp1mw892nCyx4zNTH4o7iDq6vu7ym7TsdQn1g05UMFGWGkS3LlfzWmfs6ywOk99yw7Dx97wx+gW/3e5xEiFgO/fHi/HgbvtJX4IJS/zT2P27BUjQ4V3SL7o6JRp/oBLlsIy946P4umhZSpVNnoEOf8zrYQ3X2+mgCU5Zj5K4hmAoSVos7lE8rYUhrg8aCrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCsB/lVFWfGhXiV0l4jtmoYyz74PN1Ez1rQQdMCMYfM=;
 b=oeIyKwMnT2iK9EDsqt5OjAaMR3P04tGbGJsF0W4lZTWttpf3+6Er9N67/qFMAOa29Gn2vf29CjsUMBVj7X+rYwD3W+BtMaa6LrAEswC9HghI32TLzcX+rN+OmMVYs4uElT6a6tQEQYbrhRCbqNjKf7guBkrr00o8zQ2xpNY1PmQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM8PR11MB5621.namprd11.prod.outlook.com (2603:10b6:8:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 18:44:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 18:44:46 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] soc: sifive: ccache: use pr_fmt() to remove
 CCACHE: prefixes
Thread-Topic: [PATCH v2 5/6] soc: sifive: ccache: use pr_fmt() to remove
 CCACHE: prefixes
Thread-Index: AQHYwQH/otr7rLw2PEiT1Rv9pqAAtq3RLR8A
Date:   Mon, 5 Sep 2022 18:44:46 +0000
Message-ID: <74571708-be33-bee2-fdc2-01492f121cda@microchip.com>
References: <20220905083125.29426-1-zong.li@sifive.com>
 <20220905083125.29426-6-zong.li@sifive.com>
In-Reply-To: <20220905083125.29426-6-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62901466-a30a-44f1-618a-08da8f6eb497
x-ms-traffictypediagnostic: DM8PR11MB5621:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bmFZ0vr5uOTnG8CqE2LcvDMWfD9pJgZvHFi3AstaRMqo/0TGYOS0k5Yn9Xe/4sm4c+e76IrrBXzjaXQaY1SAtB8XpImw2zt7vknqvjKWm9HH7JWOcbOK0L0BR1mxgHIu200/RqkI6OMty2Es6KfUAFHokC/QkWmHw44uBVUoXxJwVJ0X0YtgEsaPzFmMp9DW/5QGv8Q1Ruv7AbHoDzjrJOHk1Eauh4iCvE9NPUsdmlntXwplqx451DuniN6eAVdKEmQuqryTj12CN03mxpqaCmPGrdv0NouT5miHTLebg5oEXWZ886VaIY1/iOvjL8a8T8PW0papZEBBQxYAPLtYcs/8ex1If7yH2+Q3MLpEV/UwgRq0ZYPdsecVhU5qFyxUX0PnCXNAAkXvbapxfMvjhPEkZMmy94rFqkCBl6YGOWChU8QyvpbO4+IIoS+7gT7ALAGzq0mEQLiW6QS5h+6ERPAyjVOZDyqwmM/ui5bt0z6b2BKY5w5xJWx+XykDucbUeHJXjwaSLHDNE8yAr/zKt2gN3hdWJOK+wc4WeKiYYwShQ0zwtVC20dCOLNFz1PFXvl5zZ1kNmJXXmOLVs42zU2AV5ZIROJAceZGYOiz713wwBmm4T72VS9aau8muE1Jrg6vBn9ZGhgt9Y5jTm74DkYBeZ9uJE1KL+ZDFudI9NNvfjevFGUYbz/fAvtvhDE1yDb0wRYt4oKli/SlGkkosWRPKjXfd/Y2bDKwHoEeqjv8SYsTVhbm3HbsZVWtKewjE9iq6yAALhbM0XkYo8pE5bstLKQy5PHnV4CDtjTdvcf8Ws+UJeV9yLzGLzhoVy0cT1GbzTcp6a1NdaWaTOU/h1qwZEIAVsSkFZiDExtECKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(346002)(376002)(366004)(8936002)(38100700002)(41300700001)(7416002)(5660300002)(6512007)(26005)(86362001)(53546011)(31696002)(6506007)(2906002)(122000001)(31686004)(186003)(2616005)(921005)(83380400001)(38070700005)(66476007)(8676002)(66946007)(66446008)(478600001)(91956017)(71200400001)(66556008)(76116006)(316002)(6486002)(36756003)(64756008)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk1uY0djL1JwcmRrbVlwS1lsemVndkRxYWx3YmE0NmFPL2tDSVpjWnUxd043?=
 =?utf-8?B?eXlsVzdFbEVnNVlCVHFXMmdTbEh1cFUzNWRtd2orTWNrR0hLZWVHYTV5TGtT?=
 =?utf-8?B?YzJZc09QMm5HUE94WFI4K284cStrQzZGazk2c0RsbUpvaUZwQytvWEtSSGt4?=
 =?utf-8?B?dlVQVE9ZNk9RTm11aXZmbThNMXpFMkJocVpySTBVRm04RlRVcUozd1ExdXoy?=
 =?utf-8?B?UExudjI2RTdaN0xuaC9wTnY1bEZlSGplVkQ3VHhOaW11bUVOUUExc0JzZ3BY?=
 =?utf-8?B?REQ0d01ITG9YQnJBbzlOMnlnOThXNTZvNGZ0eWF1b1o5d3dseWVFbXVlb0tW?=
 =?utf-8?B?TFJ3dmF5TUZ3REpPNEg4RU0velJvc1RCUG1EWEN6RHJOQ1pTY3FmQzRkOXJZ?=
 =?utf-8?B?a1ZvcEFyUG5yalVhcU1lK1Bla0ZwL3g1SXNsTm5yczZBeFNKZTY4ekhia0J2?=
 =?utf-8?B?cHRPd3lZR0xVU3ZjVXlFUGZ2VDlXeTNnbzlvOUNUc3V5SWw3MEVtK21reUVV?=
 =?utf-8?B?OTQva3FVTTFGUnJVNmUwajdOSVhtZWE4NnR5REEyamNyYzNvMlFWRmduYmda?=
 =?utf-8?B?b2JxRkZ6QlZWL01wSDNIM3NHZ3hrWXNxQ25LTS9XZis1cEhNeFNqU2wwMytM?=
 =?utf-8?B?Y0lydk9zZUloQ29ISDJON1lHTUkzZnZJYy9oWEh3bCtZejlRMkhvRVNIMFE2?=
 =?utf-8?B?UnNYMloyZ053d0ozWkI3Y3NoeEFuM2JuQjRoLzl5S0MrZzJsQ3VCVVo4UXFM?=
 =?utf-8?B?ZG0wRXN1S3dXN0Vkc3JzeWlNWlJ5cElpVXZ6YkpNRk1yNkNrbTE4SEd0ZjMz?=
 =?utf-8?B?bnBqNzJaamxnOXFKZzgwY2hhQ1VUQ3lWYU9NV1FRMGM1RVY3bFpyZ0djbFZQ?=
 =?utf-8?B?eFdxdmR6S0p2Mk11aUZXejVpMTY1ckRpNkJhOXY4cHdDNk5VbUFOM0NaRFZG?=
 =?utf-8?B?OE04MjI0ekZLME1PbStQbXlxOUo5YzQ2emtvcnJpbFJ5RERlTk9HUnNPLy9i?=
 =?utf-8?B?bzVNUGJMMXpXSlBtazc2OGhwZzVlVXp2Y01BYStlQkd0OGJhd2Yxa1RyOEtI?=
 =?utf-8?B?cGdzam1GMGhCbkNPR3FsQ0UwaWxyQmlTUmtnTWQ3TllIUWw3YUpkaGNUWktR?=
 =?utf-8?B?MTY3VlV3bkZaSjVVa0tXMHY0UlRsYnBQOVhWQWNGYlU5SWh0YnZLMUNsWlJa?=
 =?utf-8?B?ZGtKRTdYT1lkVUo4VUlnZWFJNDFXL3c3MFBtTkZvdjR4MHEzYjFaYlFPUUQx?=
 =?utf-8?B?dUdwMXhFSGlIRVE3N3Uxbm9qanF6THA2am9UbytSSGRWRTlzNGpGV0NUY3Rz?=
 =?utf-8?B?TXhkWDlIb0ZIS2ZnYksxY3M2VXVDekdLckZMMWtsT3hMa3U2T2pTaTJ2M0NX?=
 =?utf-8?B?czloeEZyVXZYN09jeDg3cUpwRTlmckhMcm5PT09iRVhGSWxjTFhCWGR4T04z?=
 =?utf-8?B?QTVsekJ0YXlBbTlLUzR6S2N1b2dlcVhWQjVVT214dFF3c1F2M3VkMXltYkdU?=
 =?utf-8?B?V0ZJbVlCK2xxa1BYQlozSHVrNFFDcGtXVTAvcHN2eWV1SEE1blNtT29xZkNR?=
 =?utf-8?B?RkZ5aCtkdTZWaFVxT2p4TWpPaG10SEU3MGZiazQzeHZKWWhTRDB6S1dMbGR2?=
 =?utf-8?B?WDh2SmNCNnBLSGZ3SUdpYzNYQjRYMkNYZmx2ZlUxcnNJazk2N1J2ZFZpYlNh?=
 =?utf-8?B?U3NSQ280alVBYjIwWGxPUlBvTkc1MnE3Ykx0aTZZT01XY1FUeHJvSWgwd29p?=
 =?utf-8?B?aWNacmhvNG85WkFhTDVaRGVCK3Qrc2l2aGFOclh4Zll3eFk0TENoMS9tRGpz?=
 =?utf-8?B?M2tORnFlZ085bXY2Ry9xd2lFTkVtV1BJMmZYdXhXWVNpVWcvZ2NwZ0FSQTQx?=
 =?utf-8?B?eGVDbkVDWWp0c3lRUEtBTWg0YVZvb3hRQ0M3bXBwTU91VDBaTFVwWHN4dW85?=
 =?utf-8?B?dFd3U3VjWTNjOUVKSFRUSENaSzdDQmVqeHBBNmxQam5sQ3B1YnFCVFVyYUJK?=
 =?utf-8?B?KzdGYVF0Q0lkNll5TVp4N1BVbVpQd3NiWUx4b1gycXhrYlJhRUd4eEdBeVdy?=
 =?utf-8?B?RFJKVG1YMzBlTXNGWm9JTlBuelk1bHA5eHRSTk51d0VMamJ1cXVpenpOcU1X?=
 =?utf-8?Q?I10wB8nCHlvn6xBe3iE8G9puN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07FD90C90812304988879A58DE3973C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62901466-a30a-44f1-618a-08da8f6eb497
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 18:44:46.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYb8G19P5zY1fUaeGASYp6YFuJeQOyMXyKdRONLDTBldb6FMD1Q0ykjUpztnTUX9dmHeeEsspcWAmbak9Rq/TX5yNhxDVVY9f6iqZX3Mvwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5621
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
Y29tPg0KPiANCj4gVXNlIHRoZSBwcl9mbXQoKSBtYWNybyB0byBwcmVmaXggYWxsIHRoZSBvdXRw
dXQgd2l0aCAiQ0NBQ0hFOiINCj4gdG8gYXZvaWQgaGF2aW5nIHRvIHdyaXRlIGl0IG91dCBlYWNo
IHRpbWUsIG9yIG1ha2UgYSBsYXJnZSBkaWZmDQo+IHdoZW4gdGhlIG5leHQgY2hhbmdlIGNvbWVz
IGFsb25nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmVuIERvb2tzIDxiZW4uZG9va3NAc2lmaXZl
LmNvbT4NCg0KTWlzc2luZyB5b3VyIFNvQiBhZ2FpbiBoZXJlIFpvbmcgTGkgYnR3LCBvdGhlciB0
aGFuIHRoYXQ6DQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9j
aGlwLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hlLmMg
fCAxNSArKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mvc2lmaXZlL3Np
Zml2ZV9jY2FjaGUuYyBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hlLmMNCj4gaW5k
ZXggNDAxYzY3YTQ4NWUyLi5kNzQ5NjAwYzBiZjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29j
L3NpZml2ZS9zaWZpdmVfY2NhY2hlLmMNCj4gKysrIGIvZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2
ZV9jY2FjaGUuYw0KPiBAQCAtNSw2ICs1LDkgQEANCj4gICAqIENvcHlyaWdodCAoQykgMjAxOC0y
MDIyIFNpRml2ZSwgSW5jLg0KPiAgICoNCj4gICAqLw0KPiArDQo+ICsjZGVmaW5lIHByX2ZtdChm
bXQpICJDQ0FDSEU6ICIgZm10DQo+ICsNCj4gICNpbmNsdWRlIDxsaW51eC9kZWJ1Z2ZzLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfaXJx
Lmg+DQo+IEBAIC04NSwxMyArODgsMTMgQEAgc3RhdGljIHZvaWQgY2NhY2hlX2NvbmZpZ19yZWFk
KHZvaWQpDQo+IA0KPiAgICAgICAgIGNmZyA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0ND
QUNIRV9DT05GSUcpOw0KPiANCj4gLSAgICAgICBwcl9pbmZvKCJDQ0FDSEU6ICV1IGJhbmtzLCAl
dSB3YXlzLCBzZXRzL2Jhbms9JWxsdSwgYnl0ZXMvYmxvY2s9JWxsdVxuIiwNCj4gKyAgICAgICBw
cl9pbmZvKCIldSBiYW5rcywgJXUgd2F5cywgc2V0cy9iYW5rPSVsbHUsIGJ5dGVzL2Jsb2NrPSVs
bHVcbiIsDQo+ICAgICAgICAgICAgICAgICAoY2ZnICYgMHhmZiksIChjZmcgPj4gOCkgJiAweGZm
LA0KPiAgICAgICAgICAgICAgICAgQklUX1VMTCgoY2ZnID4+IDE2KSAmIDB4ZmYpLA0KPiAgICAg
ICAgICAgICAgICAgQklUX1VMTCgoY2ZnID4+IDI0KSAmIDB4ZmYpKTsNCj4gDQo+ICAgICAgICAg
Y2ZnID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX1dBWUVOQUJMRSk7DQo+IC0g
ICAgICAgcHJfaW5mbygiQ0NBQ0hFOiBJbmRleCBvZiB0aGUgbGFyZ2VzdCB3YXkgZW5hYmxlZDog
JWRcbiIsIGNmZyk7DQo+ICsgICAgICAgcHJfaW5mbygiSW5kZXggb2YgdGhlIGxhcmdlc3Qgd2F5
IGVuYWJsZWQ6ICVkXG4iLCBjZmcpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIHNpZml2ZV9jY2FjaGVfaWRzW10gPSB7DQo+IEBAIC0xNTQsNyArMTU3LDcg
QEAgc3RhdGljIGlycXJldHVybl90IGNjYWNoZV9pbnRfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpk
ZXZpY2UpDQo+ICAgICAgICAgaWYgKGlycSA9PSBnX2lycVtESVJfQ09SUl0pIHsNCj4gICAgICAg
ICAgICAgICAgIGFkZF9oID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RJUkVD
Q0ZJWF9ISUdIKTsNCj4gICAgICAgICAgICAgICAgIGFkZF9sID0gcmVhZGwoY2NhY2hlX2Jhc2Ug
KyBTSUZJVkVfQ0NBQ0hFX0RJUkVDQ0ZJWF9MT1cpOw0KPiAtICAgICAgICAgICAgICAgcHJfZXJy
KCJDQ0FDSEU6IERpckVycm9yIEAgMHglMDhYLiUwOFhcbiIsIGFkZF9oLCBhZGRfbCk7DQo+ICsg
ICAgICAgICAgICAgICBwcl9lcnIoIkRpckVycm9yIEAgMHglMDhYLiUwOFhcbiIsIGFkZF9oLCBh
ZGRfbCk7DQo+ICAgICAgICAgICAgICAgICAvKiBSZWFkaW5nIHRoaXMgcmVnaXN0ZXIgY2xlYXJz
IHRoZSBEaXJFcnJvciBpbnRlcnJ1cHQgc2lnICovDQo+ICAgICAgICAgICAgICAgICByZWFkbChj
Y2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfRElSRUNDRklYX0NPVU5UKTsNCj4gICAgICAgICAg
ICAgICAgIGF0b21pY19ub3RpZmllcl9jYWxsX2NoYWluKCZjY2FjaGVfZXJyX2NoYWluLCBTSUZJ
VkVfQ0NBQ0hFX0VSUl9UWVBFX0NFLA0KPiBAQCAtMTcyLDcgKzE3NSw3IEBAIHN0YXRpYyBpcnFy
ZXR1cm5fdCBjY2FjaGVfaW50X2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2aWNlKQ0KPiAgICAg
ICAgIGlmIChpcnEgPT0gZ19pcnFbREFUQV9DT1JSXSkgew0KPiAgICAgICAgICAgICAgICAgYWRk
X2ggPSByZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfREFURUNDRklYX0hJR0gpOw0K
PiAgICAgICAgICAgICAgICAgYWRkX2wgPSByZWFkbChjY2FjaGVfYmFzZSArIFNJRklWRV9DQ0FD
SEVfREFURUNDRklYX0xPVyk7DQo+IC0gICAgICAgICAgICAgICBwcl9lcnIoIkNDQUNIRTogRGF0
YUVycm9yIEAgMHglMDhYLiUwOFhcbiIsIGFkZF9oLCBhZGRfbCk7DQo+ICsgICAgICAgICAgICAg
ICBwcl9lcnIoIkRhdGFFcnJvciBAIDB4JTA4WC4lMDhYXG4iLCBhZGRfaCwgYWRkX2wpOw0KPiAg
ICAgICAgICAgICAgICAgLyogUmVhZGluZyB0aGlzIHJlZ2lzdGVyIGNsZWFycyB0aGUgRGF0YUVy
cm9yIGludGVycnVwdCBzaWcgKi8NCj4gICAgICAgICAgICAgICAgIHJlYWRsKGNjYWNoZV9iYXNl
ICsgU0lGSVZFX0NDQUNIRV9EQVRFQ0NGSVhfQ09VTlQpOw0KPiAgICAgICAgICAgICAgICAgYXRv
bWljX25vdGlmaWVyX2NhbGxfY2hhaW4oJmNjYWNoZV9lcnJfY2hhaW4sIFNJRklWRV9DQ0FDSEVf
RVJSX1RZUEVfQ0UsDQo+IEBAIC0xODEsNyArMTg0LDcgQEAgc3RhdGljIGlycXJldHVybl90IGNj
YWNoZV9pbnRfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpkZXZpY2UpDQo+ICAgICAgICAgaWYgKGly
cSA9PSBnX2lycVtEQVRBX1VOQ09SUl0pIHsNCj4gICAgICAgICAgICAgICAgIGFkZF9oID0gcmVh
ZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RBVEVDQ0ZBSUxfSElHSCk7DQo+ICAgICAg
ICAgICAgICAgICBhZGRfbCA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9EQVRF
Q0NGQUlMX0xPVyk7DQo+IC0gICAgICAgICAgICAgICBwcl9lcnIoIkNDQUNIRTogRGF0YUZhaWwg
QCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9sKTsNCj4gKyAgICAgICAgICAgICAgIHByX2Vy
cigiRGF0YUZhaWwgQCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9sKTsNCj4gICAgICAgICAg
ICAgICAgIC8qIFJlYWRpbmcgdGhpcyByZWdpc3RlciBjbGVhcnMgdGhlIERhdGFGYWlsIGludGVy
cnVwdCBzaWcgKi8NCj4gICAgICAgICAgICAgICAgIHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZF
X0NDQUNIRV9EQVRFQ0NGQUlMX0NPVU5UKTsNCj4gICAgICAgICAgICAgICAgIGF0b21pY19ub3Rp
Zmllcl9jYWxsX2NoYWluKCZjY2FjaGVfZXJyX2NoYWluLCBTSUZJVkVfQ0NBQ0hFX0VSUl9UWVBF
X1VFLA0KPiBAQCAtMjIxLDcgKzIyNCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHNpZml2ZV9jY2Fj
aGVfaW5pdCh2b2lkKQ0KPiAgICAgICAgICAgICAgICAgZ19pcnFbaV0gPSBpcnFfb2ZfcGFyc2Vf
YW5kX21hcChucCwgaSk7DQo+ICAgICAgICAgICAgICAgICByYyA9IHJlcXVlc3RfaXJxKGdfaXJx
W2ldLCBjY2FjaGVfaW50X2hhbmRsZXIsIDAsICJjY2FjaGVfZWNjIiwgTlVMTCk7DQo+ICAgICAg
ICAgICAgICAgICBpZiAocmMpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJD
Q0FDSEU6IENvdWxkIG5vdCByZXF1ZXN0IElSUSAlZFxuIiwgZ19pcnFbaV0pOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBwcl9lcnIoIkNvdWxkIG5vdCByZXF1ZXN0IElSUSAlZFxuIiwgZ19p
cnFbaV0pOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmM7DQo+ICAgICAgICAg
ICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiAtLQ0KPiAyLjE3LjENCj4gDQoNCg==
