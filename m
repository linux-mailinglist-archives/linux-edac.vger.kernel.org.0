Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB4613BFB
	for <lists+linux-edac@lfdr.de>; Mon, 31 Oct 2022 18:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJaRNU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 Oct 2022 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiJaRNP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 Oct 2022 13:13:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B9613CE3;
        Mon, 31 Oct 2022 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667236393; x=1698772393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QQ0yV2ftjlacRXrQmHwoLlGLm5tRVgowrPsbupkjnjM=;
  b=KzL+3IxB65NS00t16Uu6SHPYoPIAeR0QeMeeWNAB/58TWBI7ZHtW6rq+
   92Hnz368V1uLwlEHRY02G41FZ9Pfgy/ihHDsOjhDhjZvFZE240MPcM/F1
   86noeMHgN0ffkgM2yG/OZvz+nK8czgmeXDtXt32Ao56rpXnKkcAU+OF0M
   LKBQNaDWbzbNJ0s/XewfIz3tp6Pwp3eJM/E/YO0YR79UqFVQ9ye81I21Y
   rfUH+Ag1+zradlWgGVBCSmaII+PdGaIpg+qZSSSQ3pUoXO+2pLCu0psTG
   IvUN+sIDtkzFQlR0+21birFPU+1NlSsXNZPQLXFokGCifHJkvmqSrL0nO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="289344018"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="289344018"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 10:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="962848847"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="962848847"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 31 Oct 2022 10:13:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 10:13:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 10:13:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 10:13:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 10:13:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/+8uvGudKvCywOp68IiVckkHdl+hzc2Ukq3tXa7nuw3u+TX+vXthde1IllBrc+YzzIIQ3wWBIaAQARDbK36Cxj8sbNzz4ssqgeDNJ7MIxL+8wsKP3PtNDzpIoPplfpmKer63TRBqkhe7z4/7UajoegUJw/bj5glIUkAMatq30HZeS/Jo4q24VAQ84VBT3BvKjzekEqk/Ja0TJjL4iZA6/KeN9c5IapZasF4B4YhCvrx25kZp27Lp4giNOUd8g6iiNLDJ8H9953XtVyQOxjqkhfFK0kcuVAJGTU8XgFeDs0xlLvA8EI+yac+aolFIeGKJLr4H5NTyC8JxnzbwxsoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ0yV2ftjlacRXrQmHwoLlGLm5tRVgowrPsbupkjnjM=;
 b=YDum9H6DfOaozID/5l1vse0UBl5vLcl6DghAOA6LcY2eieNGqcTc5qB7geIbPN5ipI6hopZcUfM5X9pxT96jl23lmBIx/WX4/GH8Tiunxa0A5/YFeGC4ssftVN9s5jSXXX9jxMPUrqYG7BoEM+vCyAaVcfGa62/Y18/Rpr3Aeq/udAfV8zFx69CWHP7D7ID7K4rWW9T0P0OHWU+q1+/qUDvpTPTo0vX9P7Nlb1BLJdTDZ6kOyoLdM4Th040vuWcv7zpUGz+jrRtbLm5ppkJbzcc5fhk7NJoKJ4/sS6Up1wBkDH0bR/8zrCbFdkZigByDy722RqCvhTYiML+LCMMxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 17:13:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 17:13:10 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/mce: Dump the stack for recoverable machine
 checks in kernel context
Thread-Topic: [PATCH 2/2] x86/mce: Dump the stack for recoverable machine
 checks in kernel context
Thread-Index: AQHYzrzD+dYG/dJ+8UimjxgTckOY+a4o8q2AgAAG7kA=
Date:   Mon, 31 Oct 2022 17:13:10 +0000
Message-ID: <SJ1PR11MB6083593A0D18EEE0074E77ABFC379@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220922195136.54575-1-tony.luck@intel.com>
 <20220922195136.54575-3-tony.luck@intel.com> <Y1/7ewEgVZ56KlJp@zn.tnic>
In-Reply-To: <Y1/7ewEgVZ56KlJp@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6318:EE_
x-ms-office365-filtering-correlation-id: 5dbfa0ad-10f5-4616-0058-08dabb632ff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NOrZ/wFC8kvLPO8khBs/j9xQh2PF1LRUy+yg4LcTRqvemKpeYW5X0BYh44CC7TukauL/xP4XY7bS1QoDA4dS1JRaeGY31FuJq3WAQsd51RsbtMbxxx6x2CVmMmKPABz7pHelj7tE7vlGSnfBhow1S15H2EuhZVHUJGQ9BsLX0Zzi0V4f/5d9pA85+VzS6TvEbZ3Rvo3E/LK6LnD5mT8VUoYuHn+pSzCP4lpUPjyILFeeHf2N4pzpGWFLrPg0QWau8wFjdtpXBBP/DSUXMt8+EPLOYK21zerjTxwq3OCZotOXzlUPNVTMRv3b//GUTTGZfDJAOnSg4Y5UF67JgqJnzj+ER8kKAxU95DeLjsxWKQxKm0Q+9c4nVLu70zriTR2IzQELXVJwm7fD66AdVOh5w31IOBh2+ZD28grYlAHuaU4fJLWDG0hhAqePP3u4X1mCVriSnSIRrqyzJhRjVvzoC9Q+W2dyzQlMLBfOzRXF8yYSO+j+52H0mByq3PB6MDeb+CA/OF3meyL1IeP3dM3BkJExvQiI2PDcSobl+AkMY1sXU9V2yaHJtGpmnuo8tmn6UAZuPnxxex29lHZ3++CeXtCQwbUQaGqPd6NcGPoHzDCmfN9N9eJcHiFHT840WdZgr/yKh6jK88zebIKN8bgvl9xwzAbr6o6FQDBRrTHMTjsCG3AwzI56KeKautipggDyPHdFM7Vl+1yAR0OrraMi7B5BHQHcumjNm7S1h5WtR2qZ1GWLYuKw6DgaVtxgxOgZ/M7lfcJmHChvDd64H/4jGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(86362001)(33656002)(55016003)(186003)(122000001)(38100700002)(83380400001)(7696005)(9686003)(6506007)(26005)(82960400001)(4744005)(2906002)(5660300002)(52536014)(8936002)(41300700001)(38070700005)(71200400001)(66556008)(478600001)(66446008)(64756008)(66946007)(76116006)(4326008)(66476007)(316002)(6916009)(8676002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0tYaVpUZmJmMHA4ZGpCcDRoQzhHUVVTdldSQ0JrV3R2ZU1oWnJiSlByOTdU?=
 =?utf-8?B?d2U1aTRjRnRSRXNBVlRGdUlraVJyYWp0cDRLTHhSc01sdTA4RmZQdThrRkpX?=
 =?utf-8?B?ZE9lRjQ3Y1NqTGxuelVMUCt2NTRPbTVuQTU0clQrTzFwVGpWY3NjVmtac3Nq?=
 =?utf-8?B?cVAwZGVnY0hMTmE3TFZHRXlGTU5UQnBtWktPdWtxYkRmUmltcVgycWNqTFVt?=
 =?utf-8?B?R3ljNWFzMVByVkpLUGJvdWh2S2VXWkxZWmpEdnFaVzAwTWw3QitST09tOVMr?=
 =?utf-8?B?cDhhYytPZlpHU1NpSHJFRmM0cVM0bWpBZXBBR2VUNFpQRCtHNS95TFdvZE9W?=
 =?utf-8?B?ZVV1Y21BVjBQNDVQVk5JTSt2SWFKdzNFaTFKWWk0bTNYcWpVckFlRDNBcUpm?=
 =?utf-8?B?UDRVNDJpRmN5eU1qYkJ4bUFBRm5TeVJTdmxiUG5jeEFyUkJpN3JZZVJSOWZr?=
 =?utf-8?B?TElWWTdkeE9kY1pFeG5QYWlrdXpkSE9HMVRFWjZ1aUlDaUI4dE11ZWxGOGNQ?=
 =?utf-8?B?SC9IVHYwRUwwK0NIQWZJM2hvQUF1aXBKblc4VmdJWmsvM3o0UFZaZldJaEpQ?=
 =?utf-8?B?N0xrc25xNUt2WFA1MWoxcUJWN0c3QXZyQm1yK3dDVldZbU9JS2xhcHpSNVV1?=
 =?utf-8?B?TDFzdWpmdEcrNVBHTFhkUHB6STlCRU1uRktTdGt0MmxQNnlPTWoxd05nNHpW?=
 =?utf-8?B?dzNNZTVCdWlzK0w2enpHSGR4YXFFaDRLME1wbG42QU9uYy9BNWhUYnhaMEM2?=
 =?utf-8?B?dEdKeTc5R2pjVzlESENpOXpZNDZNbjIweDRzaUczUmh6KzVqNk9lREl4cDUz?=
 =?utf-8?B?dkY0Vm04SFZTK05hNkUzczBsamNzemtySDlYQ0NQYk5sczZoSys1YjN1aGI2?=
 =?utf-8?B?dEwzeG9Xb012SWEvNGVJTXBnUUZDOW5yOHhTVlFiYlNzeFR3OVRSTnE5ZjhC?=
 =?utf-8?B?U3pzUGJPSGw4c3psSFVpN25zaTYzbXBhV3prbmFzWVgyTkRIZnBXSmdyM1FW?=
 =?utf-8?B?WktIcHZCb01hcEs5MFRHY2pXVUl2YjlHN2ZyaktHeHRpR1pTQUx1eG1yTGpQ?=
 =?utf-8?B?cHpmNHZnVDBGdHFjYVhUU3FrSzVSZnJCdk5KcGd1NkY2dm5vSTB2TzUyLzZ1?=
 =?utf-8?B?T1BzV3ZmQ2dJSEZpWXdVMFNQWDk1M0EwVFYvbEhPNXJ4b0NmeHNKRmtiTUxO?=
 =?utf-8?B?UnBBUDk4N0dTTEZScWg4dERYS3ZFWlJiRktXRkd4Q0JLbzBpbW1WUi9uekFS?=
 =?utf-8?B?VmJ4T25IaGxTT1BzaUZLeTRzL1NEUk91U0pSUitZNGdvQ2VQRHpiZUk2WkVV?=
 =?utf-8?B?T0gwMisxd2oxZXZjckdlNUZiL0NYamUxVVA0T3VzeDBWWklBZktxSmhmNnZE?=
 =?utf-8?B?Wmtvb3VqYlRPZ0dtcmxHYnRGS01FSkdGcVNrSG5KZ0plVmFCOWMrcWJjcHBD?=
 =?utf-8?B?QnZOaU8wQkMwR1hoWWkrRFhPeTBSRG9kVDh5N3NUWGNVazlMd3ZSVDlXRHYw?=
 =?utf-8?B?OE5tbHJORlJsWlFTdGV6bXpxN3BpdnhEZjVadGdmdXZqM1lxY1dxa3JsTFFY?=
 =?utf-8?B?UWdyVE9NaWFnN3hIQzRRVGZUNVBWVEc3M2FPb3NIYlJzOXlDeHZPNXU5TTRS?=
 =?utf-8?B?ZU1uQ0labWR0M0xPQkV3cVZDbjdIcUJReUdYTzlINEJhMnlyQVRVeWY2aFRq?=
 =?utf-8?B?QVRJK251bGNpT3JFelZETllMbXNGL3NZb09PWSt1NFJSZ2diS2JpbXV0Mnoy?=
 =?utf-8?B?RFRyUUM2WVB4bjNpMFVNTzZ1bjZ2bkppTkUvNkV3eTdac2R6cW5ZRUJ0Zmw0?=
 =?utf-8?B?UGkyZnBUUWZMTEtjWk9xanYzTktIYi9qL1FSUkpUdFEvdkYrZHJlanRzMzdx?=
 =?utf-8?B?YVdPVmxwOHJaMWVZWVZpY3c5VUpsKzN1L3NLMDNna1FSL1Vpb2JKaXIwYzFV?=
 =?utf-8?B?aDBJTUc0TzdjaEZnMVcwVnNKWEZDNkx6VENaZFNRRUtBVGR0WmQweHhpRDlI?=
 =?utf-8?B?ZWcybWMrYjhxV2M1TjFJdkM2R0pJMmdFVFdZS0hXOVlCbzF2b202RTFvbzMz?=
 =?utf-8?B?c1lveGZ4czFadXJOdWZOZG5ZN2gvOUxmSnd2dkFrSnBUV042Wmd5aVlPdHo1?=
 =?utf-8?Q?s8fPpOj/g/ejSHFBwLQRAN/Mg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbfa0ad-10f5-4616-0058-08dabb632ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 17:13:10.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WflCca5/Tebev1E4QtyriZY8wWEwZ6N2IuRkyvIA0r3KNFYhs7nLmYKN7Qt3w/H6D7KzEbFy4ELLQ4IXUIw5ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAxLiBJZiB0aGUgZXJyb3IgaGFzIHJhaXNlZCBhIE1DRSwgdGhlbiB3ZSB3aWxsIGR1bXAgc3Rh
Y2sgYW55d2F5Lg0KDQpJIGRvbid0IHNlZSBzdGFjayBkdW1wcyBmb3IgbWFjaGluZSBjaGVjayBw
YW5pY3MuIEkgZG9uJ3QgaGF2ZSBhbnkgbm9uLXN0YW5kYXJkDQpzZXR0aW5ncyAoSSB0aGluayku
IE5vciBkbyBJIHNlZSB0aGVtIGluIHRoZSBwYW5pYyBtZXNzYWdlcyB0aGF0IG90aGVyIGZvbGtz
IHNlbmQNCnRvIG1lLg0KDQpBcmUgeW91IHNldHR0aW5nIHNvbWUgQ09ORklHIG9yIGNvbW1hbmQg
bGluZSBvcHRpb24gdG8gZ2V0IGEgc3RhY2sgZHVtcD8NCg0KLVRvbnkNCg==
