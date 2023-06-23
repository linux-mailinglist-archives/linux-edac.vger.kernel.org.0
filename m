Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2059573BBEF
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jun 2023 17:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjFWPpf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jun 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjFWPpc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Jun 2023 11:45:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018532116;
        Fri, 23 Jun 2023 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687535131; x=1719071131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w46DxZPQSoBEbPm+F76k7kRdRzxc9NGDI9UBM6GNXk0=;
  b=O8mlA+LETEnH11qAOkJAy7qfVv1824zPt1U6JDxL9RAhRVy27GVbFZDf
   XJW1N7DDFMSERcp5Ks1HwMzYSgwjs/z1+pNf23I3YUONvPlSVbECP9kUp
   ESe8wZ0EIrFcnihNa4wPvGpqvMkvHN5YBwFFSLer4vs1uMWzrYaj1xiE0
   91qPsL3L24mNnqVwDp05hSQJn2rCMO6OsOr7wXW47lT7SCYElB5Q2FT76
   EgJl2kIQtMThi9Uhf3u3whTbqL5qedAY5rrWWNjtv4/Cdfdc6sCNf3GbV
   SLmEH3EF9HTmxMHAAo4CsIEzIN4H4Er8MwQyRw86Z0YBBWXT6tTSdxDu/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="424478231"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="424478231"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 08:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="718554699"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="718554699"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2023 08:44:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 08:44:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 08:44:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 08:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU6S/hvrznC+o1AAO+7cwhQZEGCEz6EoWO9+oayfb+jWtIyyWpwbU++vxsjaZUJpq8MAst4RACiyqfK0YBzlp7Skl11MdS2eTDSnxtC/J5Wkc0KxoAd/AYGaUq5h4kwWDBZNZcvzW89bzWo7NROGJK+x90CL7jlvmGe14wkWKuK7IC/kv8Pwr1r8KnKybGkfU6vudTexbrc/utq7ETnBfyp8gpS5sryrjv28T1/iH0/0qwYp48hs0THzEu4SifhyAmyQ+ASUgdeAbDCOEWwoYnF0T8o/pqC+2FHjyCJkl0XnLbA8EfG0dQxuNhAoDo3rUMIP9EQ7TJjACA8Z8+aOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w46DxZPQSoBEbPm+F76k7kRdRzxc9NGDI9UBM6GNXk0=;
 b=h0qwmZzAbI0BtZFpeNSdXw72yD0RQ6QN7/G0XxbEJXsyiYLNnfBKp83WzKY4Oe6fd6csm+pW1KyK/sIjajQSE3vJs216nf193BEXvjHp5VE5gHsQtnqJjyGh4TAiaIWoZWo51jkRCjaSpaG4U6bor1F2OqE43pwXZvVRX3puZVCVuDdoJlGL30+aTG98bNp/c5QaQFHP2bqHPIBW0wT6VwSlgkK0iJzzZMcwkKYvt8m2sHKOekF/+Ch2rSDCCDfHS0GzmrcqI6WNtu/i8EZOsBLKHeilnkuQiN8nE5drGXNJhloAUTbg3/HNGObPq6EW9gVlL1beBG+R1cZ4wrrqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB5765.namprd11.prod.outlook.com (2603:10b6:510:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 15:44:06 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 15:44:06 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Raj, Ashok" <ashok.raj@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Thread-Topic: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Thread-Index: AQHZpQwiSV5YEcM40EuivrL9zu2Y2a+W8n2QgAAPY4CAAAqHsIAAJ6WAgAAC79CAATKggIAAHsJA
Date:   Fri, 23 Jun 2023 15:44:06 +0000
Message-ID: <SJ1PR11MB6083662CBA9A2F40512034D0FC23A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230622131841.3153672-1-yazen.ghannam@amd.com>
 <20230622131841.3153672-2-yazen.ghannam@amd.com>
 <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
 <SJ1PR11MB6083961DFCA3D90922824189FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <77d51e2f-cd1c-9c30-5bd5-42b1d583db53@amd.com>
 <SJ1PR11MB60831A6E82329E1C53257F3EFC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <e6b1af5a-774a-c3ef-223e-4595b7ec532a@amd.com>
In-Reply-To: <e6b1af5a-774a-c3ef-223e-4595b7ec532a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB5765:EE_
x-ms-office365-filtering-correlation-id: a0a553ac-6c6b-4509-d727-08db7400ad9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aF8Wvr4sPm9JPzcJZ4Wjbcx8mD1dYO4n2JbUqJMMAX6TYyFEFJIaaUlLLWj6g7WDvWxMuH5ouAKw71HC+FK0C3gi95S7SFTXn6PsFD6Emx7bdWfmPzqlALGMQs83ZRxkZaxVgrjh4OzVbEYTDIZHbUBQC5ZF1Pfe0RRK0TSS/stdbK+70y2AGUDAYZYodY79/7U+9tudOlw91+etEMjTcASHHKVBxeRYtMGaGK0gb4znUL6hcqg8eZhwhd+O9ImA1CSbsATYio3jFuV3AhYQPUAjsBHTFuKP98koNOcuzJBlrDHDN/6cm/Lhw04/94wAXZSothomeFfwf/enG9QRoYCxmfXyLkrbvfxYLw4SJIi9EAmKqR43vCpFV5If4VZGefJQhHR1SuhDz8aMrrUTolis9MvWftO8oCrfoak+l/VwUaXO6F+8rpWVcsk1Gkc2BzK5rNcHuc9jXvVZAy65Eq5GH6nQp6XRbuMBOBQsmujrFYkbRPnl4NdD9SOVBaAM9HD1Ag9vMZ7ymg5anqzLm52k4dxiXeNwoYgEq7hhSE4BdqRVwZIXeYKtSaMOCK63z+sxY72IJdxAC1fUJKXpcDgDWpCfpwMm11rrCQq4sD7hu9kDRroklYohSdVPb6TR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(82960400001)(122000001)(38070700005)(55016003)(38100700002)(83380400001)(316002)(71200400001)(66946007)(66556008)(66476007)(66446008)(8676002)(4326008)(64756008)(7696005)(41300700001)(6636002)(8936002)(110136005)(54906003)(4744005)(76116006)(478600001)(2906002)(26005)(186003)(9686003)(52536014)(5660300002)(6506007)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW4vR0NURXNuYlozRnBLcVcwQXZoeVdLLytVbjNwZklHM1luUTNueUl2V1pT?=
 =?utf-8?B?VnV4T04yRHc1UFlKUUZla1lwUENLTU5aMGZmNitZMjRicjdTWTZMQXRUdUNS?=
 =?utf-8?B?ZmR2WXpKRTlON0k1N0YwVkZKZVNOOEovVmtHdmk2b0lwYUVJNlVsUkpUNUxj?=
 =?utf-8?B?VzRWV0pCaFFtQ1VMTE1kOGEwd0VPV3FVOW1sRzVqUk9aNzRTbTJ3bXlhWTVZ?=
 =?utf-8?B?eTJWMzFndlBpU0ZJb2M3dVlKd2ZKL1E5TlNMMVdJWkFsYkYvNzVRYVNESmZV?=
 =?utf-8?B?NnZ0M0h1U29BWmlRZFBCUmtKNE5WbXREdVpFbEUydUM0YUVIN1pBelA5azdk?=
 =?utf-8?B?bm9rU1ZzZkdjWmZnRjR2eW13MUlVc1RxUEdKaWY4eDllaGJSN2hMMlI5bGtm?=
 =?utf-8?B?Y0VJbEJBSnYrdnRqTElFS3VZcVFrQWsvRHRYekM5MDcxdnVzWVpuc3NST2dp?=
 =?utf-8?B?SmgzNkdlM3F3Z0VhNnF5aFNncGQwWUw5alJFVCtUSENvRTJZdDBYS3ZJQ3lT?=
 =?utf-8?B?V2lGbFZKVWF1MG1ZOEVJSUpwbCtPMGI5c3g5b2lkYldFZWlMczNRdG9lYjVr?=
 =?utf-8?B?MG9mK3c5Z1N4K2w3Y2ZDa0xFMmV5eGNQWVpMbEtlNkRxbmp0RHc5OEhWNmhO?=
 =?utf-8?B?dXVhNVRmQmFFU3FVMkdMNTlmVExBWVNFYUJXeUorSFJDQTI2Ulhjc3FrdTNW?=
 =?utf-8?B?dUEvQkpCWUpvaGZQd2ZSMlNyZjJzTDRHUFNHUXJTYzBab3NFYm1VdENOWjVv?=
 =?utf-8?B?QW1pb3VyMStJV29NRU1YTlhVUHd6dlFmRXZDY1hMUHh5WmZGMkJSOER6Rzds?=
 =?utf-8?B?RVVXZFlhaVN2V2grdEdJOGQ4NkNISE9vb1JFY0tJVXRoTFpNR0R3aXc4VEc4?=
 =?utf-8?B?d01aVW1vTlpHblVneFd0UVVWdis2VjBUUXJKQVIvZktnNEp2MDJuSEp5YXF2?=
 =?utf-8?B?SUFpRjBHRzJuSjRkTDdFK0o5SVVvSlVkVzFIdklseElqNTZGVElwRVJWeTE4?=
 =?utf-8?B?bElrQW5oM05HR2RMbm9Pb0VlSlVUaEV2bFRwbzZMNytCSHdNdUdjbnNDZTRN?=
 =?utf-8?B?U3ovWFEvRmlKdXY2SGRzaUYwd3Fma0x2MUZCWGtRVnJsZGhsQnVFbHBTMWd5?=
 =?utf-8?B?bjI2bk8vRlBNSGtCMlZVSEk0VXpNV3NWSVNlVVNMZFUxOW94V3VsU2ZudW1h?=
 =?utf-8?B?MGhUS2M5OG0rUzhQK2ZoN3dXeGIrbjFvZkR1NktvUndLbXpicWR1QStLczRx?=
 =?utf-8?B?T3BtWXQ2bEZFdDhldUpmUHNheFZmRDExOGc1QWhoZG9FRG9DV0QyTVNtSE1h?=
 =?utf-8?B?S2NDSlU3MTNsUDducEhoeCsvUHBtYzRLTFc2YVZyaCtDUmZ4VkFZQ1greWhI?=
 =?utf-8?B?UHJZYlRTVi9JeG1KUnZnd0lCa0swdDZUVFlIOFozdEhqQk84M0xlYkt0NWpt?=
 =?utf-8?B?Rk5xdGI4U3VJWHY5L1VTd3VmSHNUMzhzdm16d2NKTDdtR05Zb2NHaVdTRy8y?=
 =?utf-8?B?ZitLaFBwRTNOaTZtNFkyWGNUaFJ6a3FQSHhIVlI3M1cza2ltalY2c0VndXM2?=
 =?utf-8?B?cFNYRGFOV2laSjg1VElsbWF3dUorUEhiRlpsT2xYUzNOZkJyRzZ5SHg3QUtP?=
 =?utf-8?B?ZFhGU0RqU09idDk1OEl0aGp2MDF0Tjc1RXkyVk5zRDhJSnFMSUVOUUJEOGpX?=
 =?utf-8?B?cE42MVMyd3hvUjhydHR4RVIrdWNvVkgzQ0RlZzJOZ0VjQUtrMm5KSDBqeWRa?=
 =?utf-8?B?MzFEZ3RNY3FtTVZub09kK0k5Qnl3VGpYNlRsQjZKSVJWeEhvVVBWMDB0bUxt?=
 =?utf-8?B?SXRsWFVyRWNWL3hhRTBEV0F5anRaVmFGd0tMZCs5K3JHTmVkeituYnpzRk5r?=
 =?utf-8?B?b2wzYjNHV21Sd2xHWHlOdng5SzJlNjV1emlHTEFDSk41REJnekF5bzVFVFB6?=
 =?utf-8?B?ZFV6WlJ1dHZpd21uUDZ3M0NEWGZFVWh4d2pvdXBJdDVIU0dtVFlDQldpVENS?=
 =?utf-8?B?eGgwSDNsRHp0WUdWUWpTSkRUZHY0YXdYQ1ExRHJkWDFkVEhiVFQwelBDQTBn?=
 =?utf-8?B?cjRqeXFmRVovdjZ0ME4xS01XbFJUWFU1RnJhMm8zNHJPalZEM3ptQ1lneFR1?=
 =?utf-8?Q?SLPA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a553ac-6c6b-4509-d727-08db7400ad9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 15:44:06.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsZtRBaBLzhUsx7N48IQ29/ah8mcNH0yjhZagAHfDMdhj0pZU4S0KjfE+u94fLZPgQDVmbbu3FzJHcsV13LT2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5765
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBCdXQgSSBkb24ndCBrbm93IGFib3V0IG0tPmNwdWlkLiBNaXhpbmcgcHJvY2Vzc29yIHJldmlz
aW9ucyBpcyBub3QgDQo+IGFsbG93ZWQgb24gQU1EIHN5c3RlbXMsIGFuZCBJIGRvbid0IGtub3cg
YWJvdXQgb3RoZXIgdmVuZG9ycy4gU28gSSdkIA0KPiBsZWF2ZSBtLT5jcHVpZCBhcyBnbG9iYWwg
dW5sZXNzIHRoZXJlJ3MgYSBzdHJvbmcgY2FzZSBvdGhlcndpc2UuDQoNClRoZXJlIGlzIChvciB3
YXMpIHN1cHBvcnQgZm9yIG1peGVkIHN0ZXBwaW5nIGluIHRoZSBtaWNyb2NvZGUgdXBkYXRlDQpj
b2RlLiBOb3Qgc3VyZSBpZiBCb3JpcyBhbmQgQXNob2sgY2FtZSB0byBhbnkgYWdyZWVtZW50IG9u
IGtlZXBpbmcgaXQuDQoNCi1Ub255DQo=
