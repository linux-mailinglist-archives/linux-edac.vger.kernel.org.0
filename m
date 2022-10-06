Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B35F6C7C
	for <lists+linux-edac@lfdr.de>; Thu,  6 Oct 2022 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJFRE0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Oct 2022 13:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJFREZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Oct 2022 13:04:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69929696C2
        for <linux-edac@vger.kernel.org>; Thu,  6 Oct 2022 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665075864; x=1696611864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w6jmVG9xsh2m2lMIEvNYxPS+qLxSqRiLuizFePvsreg=;
  b=lFYAlUdv9P+TeLayOMQPN/OkdGn9JhAdrF58J/dBTwRdfh4sYtEB5Dy/
   S5Re07E16OoshXrqaPGt2+0SbejetgJOImoJC6MofUayZoBl4H9iWMEim
   KQSFJddO+4qQcCPtWSPUbFfsE7ls+WQHFGcJT0rUX8kef84JyPwcsv7ja
   XvZ612lAOPz17NqmeCCYLING/EUh7Q7zOIIQCtkXd30C1esB7hHJwP1j4
   BZHul5RxkDEIZYen3L+nl3yqdvwvjnlLXm8QJx7Xux1lm7aql5ktBh79e
   CA3l2JM7i6zH8i9yegTK9wpoXu0cb4FmqVeTTNU3beo56a4sgLdcKmc/o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="283874161"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="283874161"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 10:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="657983867"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="657983867"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2022 10:03:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 10:03:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 10:03:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 10:03:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 10:03:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEczAqaA819NpaJqcNzXE+BZlb1B1g0ewe5GqNGSkWetLyz2eYYmCsxWbnRW6pnLNPNCHg/hhBnAX749ba25DsZnR0WI9SDKRzP1YdNumjLrw/3iOcOCXsSxFU2E9FCd4k2SmEa9xd+0cfjeZsJbktS68+VRiT1/zJE9l8r4qulidyvWoIr5fSBYcbxiFz0eDukfJ1Sr1wF9sp137JIrpz8ioBOP+OPKQcKcjdSis9n+o9TH9r+9dgHIRq9ucimGEH9K6liNVOhe0/vYgOkR9y44geRCIpKGuFunqpdxsVsYEP5Xiydp0W7fX13DnqbC6UBctfMh9qxGhjXR+Wv9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6jmVG9xsh2m2lMIEvNYxPS+qLxSqRiLuizFePvsreg=;
 b=Af+vmzdQH/tFFSuYd7TUVWRZgsIVsPEAJgcx7R6pU6K0575zpBQMj39Uyow6r5zAo04T7ZzUZL3ZTJxqnIHksVFW6cyAS74RZePTj1/SzkDq1sw72EwPkgatCNz405m+nV4BsRiXw0FWmEHymqskt5dFE+Bx2pLs38D5Yr2BpSrzC1rV3wrsLS4cIrgKZFaccDOugqlI6kzvjhIyMuoRunx/SXytin8HFNxrwhF2vvUGizr24SHYThioo4wu+UHwQbbC3wB/1Cb+TMomYkX7zd7rbNEUBEI4ALf6zcJXF6DH46IIPtc5fEZ/NCm+heKTJ9imY3KWbgYdzB41EzzRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 17:03:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Thu, 6 Oct 2022
 17:03:34 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jason Baron <jbaron@akamai.com>,
        Christian Lorenz <Christian.Lorenz@gromeck.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: EDAC support for 'Rocket Lake'
Thread-Topic: EDAC support for 'Rocket Lake'
Thread-Index: AQHY2ZieNkgtFG4K7kmBTuWKHHzAqq4BlkHg
Date:   Thu, 6 Oct 2022 17:03:34 +0000
Message-ID: <SJ1PR11MB608325D0EFE4BE2E72324395FC5C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <1b2f0acd-c03a-9403-406e-3c7dea7b84f5@gromeck.de>
 <Yz2hEY9XFlNJudfw@agluck-desk3.sc.intel.com>
 <4718dc61-d5a6-c3a7-a30e-a09d261589fd@akamai.com>
In-Reply-To: <4718dc61-d5a6-c3a7-a30e-a09d261589fd@akamai.com>
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
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4789:EE_
x-ms-office365-filtering-correlation-id: 57d5c800-3663-4547-9d2b-08daa7bcb465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zX8qJAJkIlVzu+Mxv3nC/l4udRWuyk7vRswhr3eHbdAg3d2nMEdGS1x5innHx8T5dVKq9UVfKsIQtp5uV2g/qJviPO2By+tttun0krFXTmU0JVvrVkiZHv6ybd0BhAyAAI7cSAFzSQhIHFxiCQHkzBBDHIgOfxDtEP6xX03973B1lQ3ekFqR9jZR1Q20TDm4yvkmT1zxSuPX67bJHN16faCAAJbSYXr+ZrJcpqGexZGWKJtWL6nMpFWBEsNogmUO1QwMYjNfpXl0aDdrmuTBhuBBj/heHePlsv/IpaCxjkCmBdxwwK7LuoHsOrXF3bz74BsQrO2FDokT9gCbE+Ufk5ltmyj4T+bUcqFGiGZpkpWdpOkD7TRIlUOwrT4rVj4XEpbCmUDl/cURPNdz+jj35xRx8U/75bAIqv9VRPbHb8RsE83AwGyurqUxMzMj5XMhzM9eO+6N/vSzObudLxkKgD0Il5iUxYsH3KgDe1b+LQQnMDUM9OKBWjs0peCBuwYF4W9CnKyY4SoUDeJYGOsGPs9jzUzb9+ZNodtruvHCgHarf+OQggVW3Q/PtNBL4+4V2Ce3CMiEqKEZdSc92MnqJicgJcD6KwWU5ZEN2sfuTlDbGXB3khx9XcgCBCeezQx0hrCo4QDay6mLKqLTq9daP4RFnZmCCPGUEDdJJ0ZXcobmXITIURzwBQ/x2L/SvaxtNwJQB0kXS3+ezzX0uKoOqFJKluLZxGd1pFR115J/efU2z9Aqi8O9u6urRH7aoJEKVcKzWvV8m21ABnSSMYaSjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199015)(33656002)(86362001)(110136005)(38070700005)(4744005)(122000001)(38100700002)(52536014)(186003)(82960400001)(83380400001)(26005)(7696005)(9686003)(71200400001)(6506007)(478600001)(66446008)(316002)(66556008)(8676002)(76116006)(66476007)(64756008)(4326008)(66946007)(8936002)(5660300002)(2906002)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnMvMDJmODF0QmJKbnN2S09DaklBM2pDMktuelBmN3dlRklsK0R2Zi9FeXM0?=
 =?utf-8?B?eFZ4ZnJselNoRm5uWFRnQTZLYWlmQVoxbFNBZVJOZkx3cFFwZU9wNHZCWGdV?=
 =?utf-8?B?VnN3cDhodWpIK2h6QWVmcnB4N204eEtnRUJ0MW1yZ1hDcTU0S1h5M1JtVHZH?=
 =?utf-8?B?RExxTG5EU1g0bFpPeGM4emRFcXQ5SnlYbCtRNzRUS01BbWFMWmh4RGZJNzB4?=
 =?utf-8?B?ZkJiakpYaVYwK0swSndoelg2cTFkc0grdEZDdEJ3ZURzK2htUURNVE14Z1Iv?=
 =?utf-8?B?aHY1SlRadGlBbHFYVGU3b2lUWDBDMExhWXFBWUljTjd0Y1VLNXBNSFVMUUZx?=
 =?utf-8?B?dTB5VGZhdUVYQUdpMVVFQ2dkTnRjMVBOVUw0WWZrMGNZWWlzcEZtekVHT0I1?=
 =?utf-8?B?T1ppZDlGaEhtTnRCRVFZUk8rZGNseXZmSXpzYWVMZ2gySk56a0oySHJwWU15?=
 =?utf-8?B?T0VaZkdKYlVVWXU0RkhsVzV2NFJhUU5YSTg5Z3lVdHU0VVNud0JRTWwrNHJW?=
 =?utf-8?B?L3FHampOanlLcXRZemlzWEh3ZDdVT3lDcGdERFk3SUE5eG5oT3BNOWhCc2Vo?=
 =?utf-8?B?Y3p6RlI5MFhRM1VnT0s3S0VRR3RtNEI0VnlqZXZGMzF0MFR6ZFU0R3hqTWFL?=
 =?utf-8?B?cWxITTBUanZ3KzIxSWkvZ3VXODBERTZGWUVRcW8xeEMzc21mb1l1czVORHdV?=
 =?utf-8?B?NVI1V29wdnM2T1FTTTIxSFRWc1JzNm5SZmYzWUFnSGVWMWRaSU5xUUJrVHZK?=
 =?utf-8?B?VlhUTEx4TUp0U3dCVnFmMmlUQnhGNkhSWm5vRnlqb1NWY1pYQitXeUROVzYr?=
 =?utf-8?B?cjNNVUdmTVN5ZFdDQUh6QzZSY0xkZGEvclJvV1dqOUozbE9WZEY4aHdldStO?=
 =?utf-8?B?c3hDejRiS3pqci9uZVB6TmpoTVgwb3hiT281cFRrRWc2NnlieERBOTdaZDdZ?=
 =?utf-8?B?T2d2VFdVUHdncUZDejYxcTdFUngwWFFDRG5IOVh5aXczQktYSTllS1ZYOXNp?=
 =?utf-8?B?eUl1dGZRYWt6ZHJIWUdOZW4zNm94czJKT2JmamZiWllvQ0J5N1ZjcHZLb0Vp?=
 =?utf-8?B?MVFldDZsZ0F5TWdQc3l0cDJRREx0Q290L2dSVDVQc2M0R2dUQ0tvQlp2UnZ6?=
 =?utf-8?B?c3AxWWFWL2RNMVRQQ3dUL3NCZzZBeFFZME94bUhkL3hXTE9CRk9saUErM0Np?=
 =?utf-8?B?dTZBWUtpZlNoUmlGcEx5djZvNjY0am9KQjFyTWN1SlBwVkVnRkhvdzV4eTdk?=
 =?utf-8?B?SHZrWW1YS0FYNlpCVW05eXM4dDJYYmFqd1cramVlNGxHVk5mRjk5d1JWTG1o?=
 =?utf-8?B?MjZLeUd5RlVUM0YrZGoyc0pzQnBJd0FDR1Y4bGxXTmowUFBYOXM2QzhBNG9W?=
 =?utf-8?B?dVAwQld4ZldTZy9SOUNFRm1PV09zVEd5TEZzQ2VHck9FaGNaZG52RWo0WVU2?=
 =?utf-8?B?YWZnTmNJWHlHeUJFaUpsMURFTkNyTFZoNVZCWUlYZVJOSE5JM0JKRjlOaUxG?=
 =?utf-8?B?WnFVcUFTRmY5K3pJeVFZMDY5cFlhZzBEdzF4YmVCWVVGaEtKTlVVQUJOd0dz?=
 =?utf-8?B?Zys3Y1l0RVR1bXZNdmpBbnE5VTRkWGdOT0k5S0NGaSs5blBBSWRyazdkWW5O?=
 =?utf-8?B?cE9HMEhVL2FLZU4xSks2NXlSZEN2YlhRUy9FeE5XeHZOK3BoMTg0WlVwTFQ1?=
 =?utf-8?B?RFFaaklTWmp3blY5d3dMcVM1U0ZRMFBwVlc1bzNMRjJkemJqbUtsbXdBMzdC?=
 =?utf-8?B?d1AvRUNaT2RJRmNnUkVNbFhIUmw2QjlDS2xlUmhFTVo3L0tGZk9VZzVOUFdX?=
 =?utf-8?B?S1AxRzZTR2FLdVZoR2JkbW1WN3I5a08vQW11NGVGaUtnY3ErRUV5SFJOZWVo?=
 =?utf-8?B?TWJMZnBQdjFOUjl4WXlLekcyVWFaMUducG9ERUF2VGgvYTVYbE1BN2dETHJP?=
 =?utf-8?B?WmdneGV6SXFHeElCaUFmdFBrTW4xRVJBNXpzQWFhYWtWVG5Nc2llV2ZKSWUz?=
 =?utf-8?B?YStRSDgvQXJwbFNwR3FPbytaOHpZWFRNZ2llMS8yYlUyUzRyNkV6d3ZhdE83?=
 =?utf-8?B?YUc4aWpteDZacnRtQVErR0JsZSt6akRNY3pwVko4SU9ROFpXaCsySUdJbCtU?=
 =?utf-8?Q?lXCLdZhIKDUuoZhQMTiclewd+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d5c800-3663-4547-9d2b-08daa7bcb465
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 17:03:34.7970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fASZlSK2VaeWSD6bd24TxgE64TIV1j8uoWNzY4CQdlMwXfPuKQQ6/JCfVZy9RKyN/NIbY0FG8agTINSEuX9ayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBJJ3ZlIHJlYWxseSBvbmx5IGFkZGVkIGhhcmR3YXJlIEkgaGF2ZSBhY2Nlc3MgdG8sIGFuZCB3
ZSBkb24ndCBoYXZlDQo+ICdSb2NrZXQgTGFrZScuIEknbSBoYXBweSB0byBoZWxwIHdvcmsgb24g
c3VwcG9ydCBpZiB5b3UgaGF2ZSBhIGRhdGFzaGVldA0KPiBhbmQgY2FuIHRlc3QuIEl0IG1heSBi
ZSBhcyBlYXN5IGFzIGFkZGluZyBzb21lIG5ldyBwY2kgaWRzIGZvciBleGFtcGxlOg0KDQpKYXNv
biwNCg0KU29tZSB3ZWIgc2VhcmNoaW5nIGhhc24ndCB0dXJuZWQgdXAgYSBwdWJsaWMgZGF0YSBz
aGVldC4gVGhlIEVEUyB2b2x1bWUgMg0KaXMgSW50ZWwgRG9jICMgNjE1OTI0LiBEbyB5b3UgaGF2
ZSBhY2Nlc3MgdGhyb3VnaCBBa2FtYWk/IElmIHRoYXQgY29uZmlybXMgdGhhdA0KeW91IGp1c3Qg
bmVlZCB0byBhZGQgc29tZSBuZXcgUENJIElEcyBldGMuIHRoZW4gSSBjYW4gZ2V0IHNvbWVvbmUg
dG8gbWFrZQ0KaXQgT0sgdG8gcG9zdCBhIHBhdGNoLg0KDQpUZXN0aW5nIGlzIGhhcmRlci4gSSBj
YW4gcHJvYmFibHkgZ2V0IGFjY2VzcyB0byBhIHJvY2tldCBsYWtlIGludGVybmFsbHkuIEJ1dA0K
SSBkb24ndCB0aGluayB0aG9zZSBzdXBwb3J0IEFDUEkgZXJyb3IgaW5qZWN0aW9uLiBTbyB3b3Vs
ZCBvbmx5IGJlIGFibGUgdG8gYmFzaWMNCiJkb2VzIHRoZSBkcml2ZXIgbG9hZCIgdGVzdC4gTm90
ICJkb2VzIGl0IHJlcG9ydCBtZW1vcnkgZXJyb3JzIGNvcnJlY3RseSIuDQoNCi1Ub255DQo=
