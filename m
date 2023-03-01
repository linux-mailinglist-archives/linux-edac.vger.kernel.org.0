Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29DF6A76AF
	for <lists+linux-edac@lfdr.de>; Wed,  1 Mar 2023 23:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCAWQs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Mar 2023 17:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjCAWQp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 1 Mar 2023 17:16:45 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A43515D8;
        Wed,  1 Mar 2023 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677709004; x=1709245004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7ZpT32gTFSvcFteLfdUjcSbbQ4yBOYmHKx5wV5GJdpM=;
  b=GUYk75WFrd6Mkm4MBXL3XR6hWpW0EaGghouGQPROF6i8o1WVWoo+Z89X
   mImLsWnLztRZnQVYfHNuODzw2bdM/es1Ny475BJQ0Ket3byN1It1Iw6W7
   zvnoSPdNkf/vU/Oqfg/MmnsDojSezMMMPp09RPobRNVtasgB3nDODZw5g
   WikhK0cGEN2AsrkBWihgRv97QEs/whPSN3k6qO+SZm9F8LnIC5BH8ii9f
   5y2g0Ry9Zhl4wFoyLqevwLm6NYcsWZ/RL4OC+PANm6y8UzKafU65Uh7Hy
   hyxnXT3PPK7OMvtiKMDclsED3H/kW0mUDGLRX5egg02EkaABzZFB8yzRb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333259497"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="333259497"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 14:16:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="707162164"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="707162164"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2023 14:16:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 14:16:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 14:16:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 14:16:42 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 14:16:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liD8ubq99cWY7vlNJYxsHDw8IduvZejX/T452Mwx+uaAHrdmEwGMcLaMT05jdiWHUskoj53X4k2pSNC38PkqCVI5VXU5NpyqCdhRmy1dxxYPnVvPlbY+7zxv4FqqGhnSlQo+spkthuvCp36X5dmzwDtZo/4KOvsc0fu7ignWHExaBDYt7WAHg7BoaVFtDdfPX/qofacwGqXNdvDAPUe/w4r4ExOvah2Qf9sBRA8i40cWFFAE4BGrRNUYs4rAVrgqJVplTwciWaYbb1Qf4YDY9/U7oXZRdcdxnY1EuZ4t//jxRobVe6wfkz1gVmZ5tSxuWM4X33NVpnBQ0fAIDJu6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZpT32gTFSvcFteLfdUjcSbbQ4yBOYmHKx5wV5GJdpM=;
 b=gq9JhQzBd+E9RM0mNMafq0cKni+n8XPbx/WFtoy379oe5sXBD+jSsheqt16rwSMpJ05PCOgmzgthXjenROE0jd1sourCqGQdHa2YIUvoKHaP6YQiVkhU3FFpCZX9eoTaG19gYZVHcyxF5Fx7o7CsLE4aVWVG63kKkIEE+diZXpkWy+iel2Ee4HXku5bTwLDMXCBzy1FIsv55BRUstwxCaNpzIsMYU1sLnuyR3UBvdBOYRe/F4jgMkG9VkSCK+0Pwz81+Tkci/zbSC5qZzbhZNlu095m4TNiL/s7OMEpx505vIuwg1fcFPQ5/A97Cg2iqVDnhs5B/E2DCWfUFWidT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 22:16:40 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6134.026; Wed, 1 Mar 2023
 22:16:39 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2] x86/mce: Schedule work after restart from sysfs update
Thread-Topic: [PATCH v2] x86/mce: Schedule work after restart from sysfs
 update
Thread-Index: AQHZTIs72xd8z6iXVkqJharqMuIVQq7mfbRQ
Date:   Wed, 1 Mar 2023 22:16:39 +0000
Message-ID: <SJ1PR11MB6083E48E4CCF947B25C91801FCAD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230301221420.2203184-1-yazen.ghannam@amd.com>
In-Reply-To: <20230301221420.2203184-1-yazen.ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6679:EE_
x-ms-office365-filtering-correlation-id: 7b287688-a783-4817-e615-08db1aa2a16f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2smABmWb3MqFNX5Qg5FU+hsvgua1a0merheZoG8UhN+OTMGEHUGRHcapQ8X6uz393AxG/1c/2nVlbByC42gW17sRGYZIkoAoOvxCiSAAvc2XFoDM5mw9StAs/tMKWHxJPQZ79pG9H4L/JXBT3tIY0nAt8NajNH7qAVYkXjV8X776iDFyr3pLBHPZyNwEgZNaAIZtkVSUGBrUkYPEQzKaIkhx4/PiLD5tgWa0HqYnaCfuTzmhe+wGZEdMcnwXkx8BJlTzQ/ANoxgLYVGmeBwSvP7EJzJcKOoQrxscF2kel17xrq6af4BOuJu/dPW1z94lCSEGHK2SrzWmIXVcDzSm4qTSNm50nqAPxQ/vvzYhXwL36JbU8FYB8p6GUFgGGofMG0uC+U0erJtZW7g1OJRTNgGHa5cv9X2faLsskTMIeNBCLvi7m72Rwl8JS6yxct9h8+6QNi1bBXtCPgc5t7eHYJ4nrx8piS8aVCTa9lhgGsLn8Se4S+otz4b2DE41RKVq51o1RHegJS1hoPGyyo3byM2oKpzpUPZzUi+dcNsP9euR5Z/UIeL/0HsKZdiTsLHyltYfL1I4cmnuherDmLoqOm8O8zXpUJmdWY0Ieh2+3VWAz2n6CeStPq89URad2azB3JxtCfdHukdohJCeYdYeywXZMeMffBVXwFy3rgjMsvn752IN29IeSCp0HYq3+bF+CsQJYJmR4MOfI4BqVmoTQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(6506007)(9686003)(186003)(26005)(316002)(110136005)(54906003)(41300700001)(4326008)(64756008)(66446008)(66476007)(66556008)(76116006)(8676002)(7696005)(2906002)(52536014)(71200400001)(8936002)(5660300002)(82960400001)(478600001)(33656002)(38100700002)(122000001)(86362001)(558084003)(38070700005)(55016003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7LefLfrliTgya3qE+xyUJJhO8OLmdaep6i/EVUHvDWOGBsog/NqQkVMOdCdC?=
 =?us-ascii?Q?/dPBRgF5oh3I7ylLx5Z5CIiJtm79scA6ZqJ4xzCvNoqPvAaD7JEFZ2SF3DBV?=
 =?us-ascii?Q?twkk+n8O+LCSm7v9QtkAFWWFpr1llkkjKxOnfRVKdKZjz1BTrAkVZw2EtvyL?=
 =?us-ascii?Q?kzPFczbUIk0zqJmJSQ0/m5Sex12ut6fNIOinpk1qFD3L0TqgmPGgmh6zZ8Za?=
 =?us-ascii?Q?ETIsmATdpcldqXhJgQaQNid98ppheoIiOZGmRK/CRJS/EcbXZTQSEMu666CV?=
 =?us-ascii?Q?gYSY4yFgQ0iqkevZE+XUckFPigkEEEXTMh0zpdOAzOiMe/iWBaj3KZHopJNz?=
 =?us-ascii?Q?rlOUpC72uAHP1Xbmx5U/dWp0pzFt8nutWsz0D7KkII0JRYNbfpCxZ8yDuBdl?=
 =?us-ascii?Q?SomEvgKLm/eB5oCh1sTcykFzDLtVWCNIXt2ZhedBCexI6bZ91k3VHoaQPwe/?=
 =?us-ascii?Q?SNEOU622hjdtzfJNOR84O4ykRVJFuaHCQ/LtXy32P0IWWRuZGbrEHt9TcoLW?=
 =?us-ascii?Q?/+9Ny5aKc/WLjQyztunsgbvfHZVb3M03ucVBsdff1YouO07K8264DLndHiKj?=
 =?us-ascii?Q?oS8d4B7qNfcuF42vOQ9hi568xwuuhIshLbCJRxGwDdyxjvZ3tfOQ5LJCur6d?=
 =?us-ascii?Q?+iZXGlKfbhpHFHWArE9p3INCAz/PURJYI1mB9jKqdSej46vTzf0LPdM8m8Db?=
 =?us-ascii?Q?CyjX6Qtwqg1COUui8+PAH0l1nRQ9Ianf5tbhVWIWJ7loBaqJY2YtKzHLGgYf?=
 =?us-ascii?Q?fvjTl7DBeYeJ1ygb/r/n+9SBBmho1l+gfsp/7ULKR9y2qFR0c3BRY7yS36hm?=
 =?us-ascii?Q?lkThc/XV/vts53IcwwJhSUXTA4JINXCF5tqYBr0NKftRwQXOc6kS5COBFws3?=
 =?us-ascii?Q?Xbf9TwaMFm0u78I4sPdFTgHT14h9miWiKK9oZ2CIfg/0Z/PL2Z2i0880lJbz?=
 =?us-ascii?Q?lTtZly0bDautnWFjD2csrbUfdW1o+50tp8T1fdg1lk7tvIEh3i10kf45IwI8?=
 =?us-ascii?Q?CXvG9MO53w9Eq9rWBMEIIK1ZhrJ23b7/q3+Z/2MOczQvFTew8qnecmPp5Ddn?=
 =?us-ascii?Q?MTLDvtfuIWPHVDthWrx27oxVVyvubqiqoyCN97dQdbWMcy0MP1XCHdL3Ivqq?=
 =?us-ascii?Q?WPwFpdGJfdmydfeJ87kTtGaBTxglBQj+yV9Kwn+UciIb4bqRRSh+z7mS5LH/?=
 =?us-ascii?Q?vb8nt0jktJS+KGhzCHck8Zc7VZEx59J8pP1DrDbxj/Ls9JZW7Bk1w11yQGFi?=
 =?us-ascii?Q?v2ZSWz/enTBeclbeMYYUme92FMlkkfdij9UYzmf5hcL/vj5XMiVYNm0+lG4M?=
 =?us-ascii?Q?oWAyz0vn/RBoKeXX3Alzw+5TzbjPkgtglrTSYebmN/OgL86L2vlhgpHOgbOB?=
 =?us-ascii?Q?agViXCjwkfubkTenQHN50O0HmnEBiGWibybt0BeKMq0ZKwCuOWGD1IVqu77X?=
 =?us-ascii?Q?s3ckP8+yhyHzxmVXMiX3vBIBmRjK0S8vRiDTRwx1Ev1oL9hHUKAT42+lfPDw?=
 =?us-ascii?Q?UEJBax8xeEjQKgSFWS3YRFOAb38ojDfBV3faU6qjdVciTB3kvg4IFSCu+m2l?=
 =?us-ascii?Q?gGPpcpCPbp0wPZTXTY+MpE7PYhf0v2IJ5qTIk2/q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b287688-a783-4817-e615-08db1aa2a16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 22:16:39.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/ix3I5JuDrG297kykc8VRmLEzsJOQj2Tuy0b6qBu15lnkJQDUvVcGsKz7PpjwYyV2YOlXcLldydFa6HbkgwYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> Call mce_schedule_work() at the end of mce_restart() so that queued
> errors are processed.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony
