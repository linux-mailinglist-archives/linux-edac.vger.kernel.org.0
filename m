Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD960DACE
	for <lists+linux-edac@lfdr.de>; Wed, 26 Oct 2022 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJZF6K (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Oct 2022 01:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiJZF6F (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Oct 2022 01:58:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5DB2D8B
        for <linux-edac@vger.kernel.org>; Tue, 25 Oct 2022 22:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666763885; x=1698299885;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=OGc9tMLxj+XInCPH4650+H7mfwZkkt3Cdty+t7AyGFY=;
  b=aADjPQByQ3PmEOuob1KHD9O4icqRSZwQxVy+OjBaBWTKlyji26GYNvPF
   y6AA0aicziqZMaN7TRH6mIWIe3lOY5q4OFCwvFzWicpeEOGSBSzohZbfd
   p0LNY9Ez9ULnuihGD60OXAxlDEfiKjCJUr7Nkx6zsd0W7spNlg/mkc8eu
   ZqOcGCHuR/YddLesdXukyICYLpvUB2XMEnt0xNKskhsvMG3vMSek+2ZOs
   vOlrZnKgY76EvgOgPDdYQawoHvWJYadcK04yj+o6sVeplZ5zSaw04GpEH
   MSc9+RwbdGWrm6Uy6O1wzv6fXWdox4qJgZlIzIaKiHuOoekZsOGMR34eh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="287582978"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208,223";a="287582978"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 22:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="774464044"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208,223";a="774464044"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2022 22:58:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 22:58:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 22:58:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 22:58:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOcJgiA9lLveZkDNzt4whszti9KU2uEzoLdfJ5OO0BK7ag/OTjT5h5REJRY+pXlowycoS3Xtcw/qzBJvSPoNtYzss1vNy+Ni3f/uowQA2S8B6+9SZ1kUJbqVwzYHpmGShk3+o3yVew/5kO3QA6kuw+Mq3S4xka6deHDlHtkdw7u9JlDthtEa9EdRCBGyrFFPgniPcIY5bLELFsmMU+q89IIdupkT9t0zFDpzVg+9Zn5nbfZpcKb29UnXUA0zRs6hJh3ARq6M7OEOb+IPMdQeaNTzofJUmz8EAM4HJs/5dLYVy0y81uzIkD8XNENY5sPc9KgtMQGxjz2UMLZ8FoVHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PWQbUrcN4jPNnI8LT9Xh1CMIKF5mMxDlSq8XqeY2wU=;
 b=NHboyi6mOySCWO+QN9YOnWKBmTc/AHSyn5rIrSSutfTFis0BjZseCBATEJy9ny6MuRFp6tYOuYGFSQ2CQ22GfJKfMjsyXgZ8DykK+CVQmovM9/8P2QoTqDbDXvIAf59gnKUSNLBmz4y7JJWI3SGzLHJiWN+6zRBuYFlzwQJSVmGbL+oTK+2MCxnD3gOx+zi8qIunbO0KeQSzBL0hTJkjwfNYXpgJ9AY3xpcxUbg1KMpcmxnwYfRHnYSXfTs++QgqFlDdhXA9eGViy6VB34Yxy2dJqW6GRuf4/RwkqTtVK214jbgc0U0cQLyxxHVwOrUursrzKAwlrrFRayoSkKs4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Wed, 26 Oct
 2022 05:58:02 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::f21b:ac04:aef5:2017]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::f21b:ac04:aef5:2017%4]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 05:58:01 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Orion Poplawski <orion@nwra.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: EDAC igen6 error messages at boot
Thread-Topic: EDAC igen6 error messages at boot
Thread-Index: AQHY5WeuDAdwH4Nwnk+1Shv6FHJ5fq4ebGxQgAAEN4CAAALJYIAAzrsAgADwLNA=
Date:   Wed, 26 Oct 2022 05:58:01 +0000
Message-ID: <IA1PR11MB617155E9BCA54DED8687209189309@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <11240651-e924-8d8b-c2f7-c6e031e6b95a@nwra.com>
 <IA1PR11MB61719B0624357D88C44426E589319@IA1PR11MB6171.namprd11.prod.outlook.com>
 <1233d52b-37f1-1629-1bca-162b72da22cb@nwra.com>
 <IA1PR11MB61715701ED05952113AEF26389319@IA1PR11MB6171.namprd11.prod.outlook.com>
 <46771e87-ba19-164b-a708-87165652fa07@nwra.com>
In-Reply-To: <46771e87-ba19-164b-a708-87165652fa07@nwra.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH0PR11MB4997:EE_
x-ms-office365-filtering-correlation-id: 4aef4378-1e16-458d-f16c-08dab7170ac7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OL70BR64ocJKQ3qWdTLq80JujeWajx/hrwQktZB2ysA6JIjWVCm/GOn4tfhiwNWo7wVg4sITBX7a+hBE9UUj7OPi3TOXACb+QIjRhaQzlZc0LJMme3sfTBy32cSpl2h1E9LGtaRaP6MmXNHZcwGaDiRg7vN6iT+YOFyvHKlb8KU8dBAnOUM2Tx7NaMdHa9vFwjBdTq6xaTIFg4W3Bb+I62nRZnUPBOBIrIzHaR8lZH9TE6LNMWmIjlRP0Mc171ZuFf3DznQ/pRJX5hid/AP8druKm0FXlsSNxq0a4ypbJ5nARuI7OFS6juklPNLr8dTexOG4pcjsiP1gXBF/bstEUAZORE9zmVisPCkDrLycpuvxy1XwslpUzHS2/pHA5Gr8jOiuL4PlchmHvvZTLSstBNcAIX0V9f5SeZylkx8XPRUJiEbL0sytpvXnLCSI9NP2PjokxRhXYnqN3uCFdqC8WFoVB6V2YFENmOcSRVgJ91b6ooir/wFuZxTDNIOn8v3v1gZ/KBBEDxkPcKqKgavB/e8B8NSohLENSvyOuo6banNzqNYZcBlEuv8b5osxk7BTuxIsgup+OGbDhS/VGbwmHRP8j3IT/25KHjLQy27Djxq4IOgG3ep7LxqT76cyR8rhZ9wv8KEQDi/+jnBZZgU7i1n7SQaU6wgTdpjJmXnAoJ7IFgKbjy/2wXyA4H7g8kQYYTRDbyBXKptpFxxC3dI3NVtYYq8NzZyvDyte4sCrkdLk9up/LmeMsmD1ce8JsnSKjpOEb+kScq+A5qd/ByFJqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(5660300002)(41300700001)(9686003)(7696005)(8936002)(52536014)(66556008)(110136005)(66946007)(64756008)(66446008)(76116006)(8676002)(26005)(316002)(6506007)(122000001)(66476007)(82960400001)(38070700005)(99936003)(55016003)(186003)(38100700002)(33656002)(4744005)(86362001)(478600001)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkFsMEViUFA5QTAwZHoxT2VTbVNrUStCNkVvTno0WmxRaUxkR2NlcXZ5bXJM?=
 =?utf-8?B?VkxjM0FHMDErZ0pjLy9nWGNjZnI2bVBQN3ZJdEMxY3YyeExSWFREUEdRNXM5?=
 =?utf-8?B?SFRSb1phWlQ2cEtkZmIrQkVxV0FER3crNjhEaTZzZ29NT2h2V3dWSWtjeTN0?=
 =?utf-8?B?SUg1Mys0ZlRzVGpKMnRueTNRRFh0bUhYZkNrenV0R0gwM0Z6dDh6NURpeWc4?=
 =?utf-8?B?Q0cwUXI2TkI1eTJuVVVoaDFnOGtJUXFaalNieEZkdmJPMWVjY0ZiY2tJK2hs?=
 =?utf-8?B?cVN1YTNmbzcvVzU2dzAwOGFFRXRpb1JNWHVCKzFnZy9tSzRNODExRHpyeGI2?=
 =?utf-8?B?ZWtsTXpuKzZKc0g0UUJMR0RtZkt2LzY4b1NSN05WdVdzaFRXTlFjQVhaN1VZ?=
 =?utf-8?B?SEdtVXY3bjZDQzQxNkNCaHRwTWlXQXJ3Y0ZoNGJkUGgrQjYvZ1NSVHJPTDI3?=
 =?utf-8?B?dlF6TDgva2RYbXkrQXRMVWFMeS82TTAyckZxZWxHUW1YajdiRlBxUXFHRXZT?=
 =?utf-8?B?TE1JZmFjaEJsTWZnSzNTeHVJZ0RCdWhvY2RGSlI4RmozNDgvbEJYbDd3RkRq?=
 =?utf-8?B?TyszaEpzdDNaNm4wQm5JZi95eEZ5NEVNQ3pTRkdobFNDQjhwVnZjOEZvTllD?=
 =?utf-8?B?S3FLS0hxejBmY3NPaUx2ckZFNFF0d2ZGVGxlOHlDT1ZjOVJKU3FzaU1SaWhm?=
 =?utf-8?B?NXpCbFM4Zm4vSExMMmtUK1pCY0lNVFE3M2h2dWQvK1RaL0p1b0NheEhCZWhH?=
 =?utf-8?B?NVFUbHBtYVVseDdGQ09TRU1EYVlrOGRUK2JYQmpJM2tTQmd6OTQyUndIMzZO?=
 =?utf-8?B?SDVMaCtjbnZXVnpabi9uL25sU1B3OEtKMGV1d1lJS1BvZjRITTdkZFNsNDRP?=
 =?utf-8?B?ZjF4d2huTHBhaEV1dmJSYkhDcWFBdFV3YW1OenFkVmQ1MzRXOXBEVndkR3pM?=
 =?utf-8?B?OXEvcUlhL2J2bkc1L3hIU0RKc2FzbWVXYzZvYWw2TDZiOTRCa3NYWFpIT2gr?=
 =?utf-8?B?emNIUW1XWnJ1UTZqdHByaXFlT1VwNlRySWNGcHpUTjhTL3JIdm9sL2hJWGp2?=
 =?utf-8?B?RFJ1ZDFvWDRyZ0srcDVwUnJjeXBYeHN1b2pncDUyU2NPVGdwSlZTYVJyMkFW?=
 =?utf-8?B?WWd6d0JnVWhrM0djejkybDd5N1JUWTV0TXE3Smp4aEQrQ1JleEg2MkcxRkhY?=
 =?utf-8?B?WlkrUmVoZnM5ZEU0bUNQU0xRa1dvbjh2TldYaWhxUEVNc2FnTEVFYUx5cGsy?=
 =?utf-8?B?bDZOOEhTajJLM2pQRHptZzlFTUtLTTc3NUhDRllhU2NQVWY1eDBPTkFhS21k?=
 =?utf-8?B?VndoQndNekFhaUI2M2RWR1IwRWlUYTRiZ3R5SkV3cko1RldJQTFxODNPOG9D?=
 =?utf-8?B?U2U3WDZPRE9RbmxpRS9GMlpyTXJraFU5QTMzb3RwTGdLVVdOQ2hUeWFtUUty?=
 =?utf-8?B?YUh6RzlCeE05Smh6b1M3bzBmSHB3SjkzL3JwMFZCL0dvZWgvRG1KQnFMWUZW?=
 =?utf-8?B?RUJHZFBua1JlQ0dVM0NCSWtPQlVMYnliUWFyMjFlTDY4aDdMRHI3SHdGRzRa?=
 =?utf-8?B?RlplS3k5WTFESDhJaGVDelBEVGlrRjhoVjNjcktvV3M3S05ZNXJRandZbXhI?=
 =?utf-8?B?b2xoNjJJOWVNeVhWT1doenl4T1BVZ3FoN0dDNkhENlByL3ZXKy9yd1lTY1Js?=
 =?utf-8?B?c21Oc2k3YmZWRFhXYUJobXdhTUJOOVh2aVVOcUJLU0o5MkdmRkNzMmtIWlRa?=
 =?utf-8?B?TUtCWU5TM2FvQVp6YkNQa2s2SndsTHNzVjdhakp1c01tNmpvcS9VRHdoQWdD?=
 =?utf-8?B?TFh0THEzQnRZQk1EUW1OSm1Uc0lvSUVMK2xmbWZuZ3dZZ3JERklrSS9vaXBB?=
 =?utf-8?B?cEF0NjZGcWdSZlRWVE50WVNoMlpNOXhvUnhtVmhMZmpva0dUQXlFUHlrdWJD?=
 =?utf-8?B?VkVEWGJpc1JIbUFFaDFqMXRCNkJRZEY4WmRRSWVVY2dhdFhEdll0YlozMEdJ?=
 =?utf-8?B?Mm9aNm9YSmR2WStOMEloRlZ5bDlzMGVPRlBNNWR2M01BOGYwQ1lUdUdLaUlz?=
 =?utf-8?B?em9NVlpDd1lsa1c0M0d2ZzkycndoaTRzVXRELy8wOXlJV1BKc3BsNHV0YTV4?=
 =?utf-8?Q?KhcWs2rRAeNYR04TXvne8ZWya?=
Content-Type: multipart/mixed;
        boundary="_002_IA1PR11MB617155E9BCA54DED8687209189309IA1PR11MB6171namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aef4378-1e16-458d-f16c-08dab7170ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 05:58:01.8883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUqdb5khga/hVfkUfoEDwvjFUvaKZ8UkrzaTPGyfxB5VDRwjttu3bW6Zw4SfYet50s6dazEhVG4OKUsLZj8y7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--_002_IA1PR11MB617155E9BCA54DED8687209189309IA1PR11MB6171namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBGcm9tOiBPcmlvbiBQb3BsYXdza2kgPG9yaW9uQG53cmEuY29tPg0KPj4gLi4uDQo+ID4NCj4g
PiBZZXMsIGNhbiB5b3UgdHJ5IGEgcG93ZXIgY3ljbGUgb24gdGhlIG1hY2hpbmUgYW5kIGNoZWNr
IHdoZXRoZXIgdGhlDQo+IGVycm9yIGxvZyBzdGlsbCBvY2N1cj8NCj4gPiBUaGFua3MhDQo+IA0K
PiBTdGlsbCBoYXBwZW5zLiAgU2VlbXMgdG8gaGFwcGVuIGFsbCB0aGUgdGltZS4NCg0KVGhhbmtz
IGZvciB0aGUgZmVlZGJhY2suDQoNCkxvb2tlZCBsaWtlIHRoZSBJbi1iYW5kIEVDQyBlcnJvciBs
b2cgd2FzIGluaXRpYWxpemVkIHdpdGggdGhlIHZhbHVlIH4wVUxMIHRoYXQNCnJlc3VsdGVkIGlu
IHRoZSBzcHVyaW91cyBlcnJvcnMuDQoNCkkgZG9uJ3QgaGF2ZSBzdWNoIGEgbWFjaGluZSBmb3Ig
ZGVidWcuIENvdWxkIHlvdSBwbGVhc2UgdHJ5IHRoZSBhdHRhY2hlZCBwYXRjaCB0byBzZWUgDQp3
aGV0aGVyIGl0IGZpeGVzIHRoZSBzcHVyaW91cyBlcnJvcnMgb24gZHJpdmVyIGxvYWQ/IElmIHBv
c3NpYmxlIHBsZWFzZSBhbHNvIG9wZW4gdGhlIA0KIkNPTkZJR19FREFDX0RFQlVHPXkiIGtlcm5l
bCBjb25maWd1cmF0aW9uIGZvciBtb3JlIEVEQUMgZGVidWcgbG9ncy4NCg0KVGhhbmtzIQ0KLVFp
dXh1IA0K

--_002_IA1PR11MB617155E9BCA54DED8687209189309IA1PR11MB6171namp_
Content-Type: application/octet-stream;
	name="0001-EDAC-igen6-Fix-spurious-errors-on-driver-load.patch"
Content-Description: 0001-EDAC-igen6-Fix-spurious-errors-on-driver-load.patch
Content-Disposition: attachment;
	filename="0001-EDAC-igen6-Fix-spurious-errors-on-driver-load.patch";
	size=1228; creation-date="Wed, 26 Oct 2022 05:54:35 GMT";
	modification-date="Wed, 26 Oct 2022 05:58:01 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2YWJkZDM5YjYyNjI5OWFjNTlkODllZTM1YjRkMTc2ODZkODFmNjJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4KRGF0
ZTogV2VkLCAyNiBPY3QgMjAyMiAxMzozNDoyNiArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8xXSBF
REFDL2lnZW42OiBGaXggc3B1cmlvdXMgZXJyb3JzIG9uIGRyaXZlciBsb2FkCgpUaGUgSW4tYmFu
ZCBFQ0MgZXJyb3IgbG9nIHJlZ2lzdGVyIG1heSBiZSBpbml0aWFsaXplZCB3aXRoIHRoZSB2YWx1
ZQp+MFVMTCB0aGF0IHJlc3VsdHMgaW4gcmVwb3J0aW5nIHNwdXJpb3VzIGVycm9ycyBvbiBkcml2
ZXIgbG9hZCBhcyBiZWxvdy4KCiAgRURBQyBpZ2VuNiBNQzE6IEhBTkRMSU5HIElCRUNDIE1FTU9S
WSBFUlJPUgogIEVEQUMgaWdlbjYgTUMxOiBBRERSIDB4N2ZmZmZmZmZlMAogIEVEQUMgaWdlbjYg
TUMwOiBIQU5ETElORyBJQkVDQyBNRU1PUlkgRVJST1IKICBFREFDIGlnZW42IE1DMDogQUREUiAw
eDdmZmZmZmZmZTAKICBFREFDIGlnZW42OiB2Mi41CgpGaXggdGhlc2Ugc3B1cmlvdXMgZXJyb3Jz
IGJ5IGZpbHRlcmluZyB0aGVtIG91dC4KClJlcG9ydGVkLWJ5OiBPcmlvbiBQb3BsYXdza2kgPG9y
aW9uQG53cmEuY29tPgpTaWduZWQtb2ZmLWJ5OiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVs
LmNvbT4KLS0tCiBkcml2ZXJzL2VkYWMvaWdlbjZfZWRhYy5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9l
ZGFjL2lnZW42X2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9pZ2VuNl9lZGFjLmMKaW5kZXggYTA3YmJm
ZDA3NWQwLi5kNzAwMTQ0OTU3ZGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZWRhYy9pZ2VuNl9lZGFj
LmMKKysrIGIvZHJpdmVycy9lZGFjL2lnZW42X2VkYWMuYwpAQCAtNjUzLDcgKzY1Myw3IEBAIHN0
YXRpYyBpbnQgZWNjbG9nX2hhbmRsZXIodm9pZCkKIAkJLyogZXJyc3RzX2NsZWFyKCkgaXNuJ3Qg
Tk1JLXNhZmUuIERlbGF5IGl0IGluIHRoZSBJUlEgY29udGV4dCAqLwogCiAJCWVjY2xvZyA9IGVj
Y2xvZ19yZWFkX2FuZF9jbGVhcihpbWMpOwotCQlpZiAoIWVjY2xvZykKKwkJaWYgKCFlY2Nsb2cg
fHwgZWNjbG9nID09IH4wVUxMKQogCQkJY29udGludWU7CiAKIAkJaWYgKCFlY2Nsb2dfZ2VuX3Bv
b2xfYWRkKGksIGVjY2xvZykpCi0tIAoyLjE3LjEKCg==

--_002_IA1PR11MB617155E9BCA54DED8687209189309IA1PR11MB6171namp_--
