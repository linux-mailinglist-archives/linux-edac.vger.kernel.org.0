Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1D722E0F
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFER7W (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 13:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFER7V (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 13:59:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082EBC7
        for <linux-edac@vger.kernel.org>; Mon,  5 Jun 2023 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685987961; x=1717523961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kdcpTIrP8QJLm20LCuixeu6NK0F1/K0DNi+pHeaCZk4=;
  b=B+oEHK3EX9R7mF848BSV4EeJPQf2qnVLCbHQgcusxjiab9V+jtFvoaJA
   H6b5iKv1pp8zJM7ZU6eUiwmiDfkJCJD+U1jO6ps86w3j4YO7RzXMtqN/I
   Y0zNDn++C+tofTM3ez7gp3RIuDRMtUYGJMFkX1HA8l3EFR6sSIl1p9rwf
   5Pl36OzNGZg+UcQH3syvW054yjSfhC6bnKDGI0g5eLVJJ0FMMszQXRbLe
   +NPGSe07niJRNDCrneX0eG1SLFNLk/G/By1GyrLkMwYZMEAqq368vy84+
   6SP0F9PFNYKxY7WFTPVtY1vp0p07FiYvSwUcWf2rSUM3GUkMkAgM5+vDo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="419982786"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="419982786"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 10:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="711895809"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="711895809"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2023 10:58:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 10:58:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 10:58:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 10:58:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOWcOyW8IE8NX8oOd//hQEZzRzDd+jf1qhkbOq6XGCp1/XAPgqJh6GwPkf6UkFyHD6IcszTEuWUZGdHF6gGEFsIiAzykDl0n/mkWm0nR2JXpq+c62s0eXBRzwUd47wztFeVR/eXnKkTLcUB/lQv4mYy74bfYkthOKiCX8ss8jj5vtjh+0dN6AgJJvBbhb/8SF415zkSxhOiZdx+MNsEAVCDFZquq49FZKJRPIxMCELYdj7ysDg2E39uKfg6eCVUGI2MSS+mksdeIyl7jlwqZauoWLj2emu3UUUc0a52j6AFXmqiXYSRRojySrebZBvrhxcEIRBSyoO4P0gttoOcrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdcpTIrP8QJLm20LCuixeu6NK0F1/K0DNi+pHeaCZk4=;
 b=TFEnE0rn1gobTOPoAhrFW5Kd6QM7ic0GqD8KdwC/u+e1asWWUlI7Q9B2qNGIyog7zmkKjQh8dazqrz9YxC0qTb/EhiwM4mzlFHFsYP5ZEIGhKlNqgA1QEq7pXMSqty0KyPNtVionSDGZrLWpJrzm/StUeS7y6N+ilGOGAjgI0DYDP5pc7G6RRgEsUdyGc5EdkqNnSnA1z58cKhF72DDExTO5/yPSb4pRfjphyVXPs6/nxO+Cx+cv4HzOb8t/5qGwsG9hy5DqcsvEoLpy3Z2BcMqZiJgJMwGgecl4+TE7irf5luLazrGKzMuYDgMQ4cJN5agDlLFUmc35OF5TF3WNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6113.namprd11.prod.outlook.com (2603:10b6:930:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 17:58:40 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012%6]) with mapi id 15.20.6455.027; Mon, 5 Jun 2023
 17:58:40 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9ggAAMfoCAAALmcIAMM9WAgBL6hQCAAYhoUIAAJNkAgAABgaA=
Date:   Mon, 5 Jun 2023 17:58:40 +0000
Message-ID: <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230523141523.GL4090740@cathedrallabs.org>
 <20230604160442.GN4090740@cathedrallabs.org>
 <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
In-Reply-To: <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6113:EE_
x-ms-office365-filtering-correlation-id: 428337b2-bf84-48b3-b2e1-08db65ee7ec5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKvrYoeDfjszqcKPFVwuWl+M0mH5ntoTUdOvMXXyLFVqYRJClVFeAimnuFSKnMnrraYQF/0ziovBonyzAyxcSRM849cvlZLgACWnXIcNiFCly+0tQ6KC2KHyaT9MzlX9P0E7I6Qv33wcuZiNHH7AE3Od+OWh67JrYS5FAFwYsDjsu4Nal1wvXSlkzgy6xFjcVO3vzan9oBXehhZZVeMtrgUaf0dMCFtp1WsuV83JMPblnj8R2Y64rIs0F3HCsJ7TEyhXsDA+CAdG6RCjtgJvyGoy67ZewwnShglpzlGkQIvRVoqVRPUaPDPVoet4vFPxrVXAqfbuM5/QgWS+k0MnG0SuYELcwPqLDPLEvApHBwgQUa8hks5rMCwwswnlwyIr+wDE+152ET3sCaKwSDqTEFdcqp0q45/xAHsQ12KZK59qDaTdJQRzt02sHuwgSS54u/76YD5a592ONagdaZeeBB2V6LC251VgZfrJ5IiXAxN3T5QSIuTEBGjEC0KnwbsvtCwRrD+NpDc9qhhCl+qNkA8RghoBxzaDgyx4apU/EYg72fTz+/DODUmct22uVFUPrpE5GX36KdgqGap0JZmu56G48O99uoefgdeDSyyEPrk7Euw4mxhUEA7V5qeD8RH5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(6506007)(9686003)(38100700002)(41300700001)(7696005)(26005)(186003)(83380400001)(76116006)(71200400001)(478600001)(54906003)(4326008)(66446008)(66476007)(66556008)(64756008)(6916009)(122000001)(66946007)(55016003)(82960400001)(316002)(8676002)(5660300002)(52536014)(8936002)(2906002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVRJZmsvaXIvV05UMHFaWG9saDlTNUlqOXU3cGRTdE1pWDh0MXpneCtCa3VX?=
 =?utf-8?B?M1UvZm4ycHkreFdGdDlkMWw5UVVMMXIxTHZDVGdIazc1c3ZpOForNzJBZVZL?=
 =?utf-8?B?dG9BQ3hSVEgxV3B3anorSndCRUx4V294bDk4L3U2VFZiQ0N4d2NlaUtoeHRj?=
 =?utf-8?B?cXNCRVQ3NmdSVFUzNU1nb0ZrMzZEWGkxQ205VzV3OG5XbDMvZUdQVHpnTkJB?=
 =?utf-8?B?NTIvQitaUVNCZXRidFI4aXFud2FGaGRSazY3WHBYTFlLWHpMWUI5Z2xhTHZx?=
 =?utf-8?B?WVBCUXFYTHVXNGxNREdrdTZvQWRtNmQ4bVhJR2xzWEg3K0dUSXljWC9OK3Aw?=
 =?utf-8?B?aE9mVmZHazM0RFIrcG9NR25VbHhCSXpPOXN1R2k2L1NaWXN4eCsrSmR3aVU5?=
 =?utf-8?B?Qjl1YlNUcmYzTzR0SE94Qm81N1pTSDJqSE1tb0lncHRyMkF4djhHNHVHZVpN?=
 =?utf-8?B?VjhxeGh4TytNY1hqaGxwVjZYcGlDdmRQVE1mQjR1K1NTbTlHc1dYYTdaYXpL?=
 =?utf-8?B?VlN0YU9tSXJ2MTU0RUZsaG1pRlNLTko4ZDFBaDFjWDVHQTVxdWoxNElUaUlm?=
 =?utf-8?B?MjNXRndpU3V6dkhjT3hsY2NWeGY0cFc5Z2x2MEU5NGJCQ2lhcThnemFyK3dS?=
 =?utf-8?B?ekhoSFRBOHVMTFFUaExqRnhON0p4OWJyVlY1TGRoSGtNQUJmcVd1Ulk1VFg4?=
 =?utf-8?B?V2lZdTBtSmRqNjR1YUkzTjc1U0l6emVZNWlqYkVZclBNZWpmZklvd0lNWnBI?=
 =?utf-8?B?bFZzcDhyWW1qekR2Zlg3eFVrS1hpeHBLaFhqQS9kMm5ITi9JVXBmdmZaWEdE?=
 =?utf-8?B?NUNFMW9HeDhwLzlSRUpHb0RZSE8zeDdRcjVGM0hSdWg1Ui9pWENaRU5qZUhH?=
 =?utf-8?B?UkV0VzkrL0habEc2QVgzUzROcnIxbUpIZDhKaDlsZXRpMzVIeUtEM1ZQcU0v?=
 =?utf-8?B?US90QUtrckdJWUdXT3grK0ZoRXp0UVFFalhIUWp6RjE4QTJtejZnd3JUWUxy?=
 =?utf-8?B?ZUhQaUVQd0lqSW56NFlGYVIrT2FqbjE5UUFrSWs3THhVNWJGSGQ0RGVWN3BK?=
 =?utf-8?B?QUhrOGZ6eHQyYUtPUFEvVktNMjkvMm5VNjRmUXI5bThZbmhGYjZYMzVYTWZk?=
 =?utf-8?B?d0I4WUdmcm1tK3Q0eGlBeTBRZ3J2WlpibGFwbDNCaXV4eDJYM05xRXU4cWhT?=
 =?utf-8?B?a0o3QmNJOUlRU0lJdWd0UGNFYmhqcWxlM2NUcFZLbGQ1Z2hOMTd0NGtMUkJw?=
 =?utf-8?B?RlVtMk9STEVmUENPYlZQSmpOZ2VXZ3FyaldaM0VnVCtWM0NoK1M5OTlCNjBa?=
 =?utf-8?B?aDhjdTZ5UmZ1RU5jc2FqR1diSmcyRUVZTVppSDltRUE0ZzNBWTlmREhCVW1V?=
 =?utf-8?B?MXdoQUtuNTJQbHdUVlVUSDJ1UlpYOS84NUh0WXFVcm5waEtGeUVldk9rYnA5?=
 =?utf-8?B?Vk5VempDUzZ1TzBFOUprT2VEUGpZREhSMW1rSDQ4VThnbmtkWmRqQTAzQ2tx?=
 =?utf-8?B?ZmdIdkNtSHVLUGtiNzN3VUhxV3R4ektQc3pFei96eTVIMVIvOEN4aXYvOGMx?=
 =?utf-8?B?em9YbFdWQWYvb3RFaks3MFBjZ3d5RytSbFUwd0wvTGgwMk5FS05iTzQ3TVNO?=
 =?utf-8?B?eWI0eFRLc3NpNjQxdGhadjhIWUpGMFpybUJsVHV4aEYrZG8rMm1OQmFHNUlq?=
 =?utf-8?B?ZmR0SzNaWGVIYy9JenUrZkowR0JVTC9oZWZhV1ZtNk1QOElBb0Yza0k4cDFz?=
 =?utf-8?B?Skl4MDNOM1Arb25kajQzdE1pWEx6ZkJxM2N1Q3lTOURFRE1PL1RiVmtRVk5p?=
 =?utf-8?B?Mkg0ZCtDWkV2UEJuUUk2UVZyT3VIdkFDWjdoSFdkMnNsYjU2Q0EyM3M2R2Zp?=
 =?utf-8?B?ak15RGlWMEdqN0VJNTNjMWhJTFFMRFdXUnkwSEk5WE5OdVQxMXoveXRZNG9h?=
 =?utf-8?B?R1hEYzBYc0tRMFU2dHV0dGxYRDBHS0RLSU1tVjlJN3FmWnFIbzl3MkN1cW8r?=
 =?utf-8?B?L0JBSDFQbkFhTit0T1kzZUtZOFBkZmZOVS94S2NCYjNDQnI4NmZ0WldBZ1Q4?=
 =?utf-8?B?LzEwTUMxeEVndm52bS9ZL2tIamhwU0RSaXpQNjkzYzVObGFSZ1M2ZkNIZis2?=
 =?utf-8?Q?RAAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428337b2-bf84-48b3-b2e1-08db65ee7ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 17:58:40.6080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bp8OxZsOEo/Jdt6tVo4OJXlQtNqV45I1TM5QgKkLg3R3kMJ5egBXj745QvvyKBOI1MOU6sunU1w3tl/Qqqz1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6113
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Pj4gSSBkb24ndCBoYXZlIGFueSBvdGhlciBpZGVhcw0KPg0KPiBJIGhhdmUgc29tZToNCj4NCj4g
MS4gT25lIGNhbiB0ZWFjaCBtY2VfZ2VuX3Bvb2xfYWRkKCkgdG8gc2NhbiB3aGF0J3MgYWxyZWFk
eSBvbiB0aGUgbGlzdA0KPiAgICBhbmQgZHJvcCBkdXBsaWNhdGUgZXJyb3JzLiBOb3Qgc3VyZSBp
ZiBpdCBpcyB3b3J0aCBpdC4NCg0KVGhhdCB3b3VsZCBuZWVkIHRvIHRha2UgY2FyZSB0byBvbmx5
IHN0cmlwIG91dCB0cnVseSBkdXBsaWNhdGVkIHJlcG9ydHMsIGJ1dA0KbGVhdmUgaW4gZ2VudWlu
ZSByZXBlYXRzIG9mIGVycm9ycyBmcm9tIHRoZSBzYW1lIGxvY2F0aW9uLiBJIGFncmVlIHRoaXMg
cGF0aA0KaXNuJ3Qgd29ydGggdGFraW5nLg0KDQo+IG9yDQo+DQo+IDIuIENhcnZlIG91dCB0aGF0
IGFieXNtYWwgbG9ja2luZyBpbnRvIGEgZnVuY3Rpb24gY2FsbGVkDQo+ICAgIHBvbGxfY21jaV9k
aXNhYmxlZCgpIG9yIHNvLCBydW4gdGhpcyBmdW5jdGlvbiBvbmx5IG9uIENNQ0kgbWFjaGluZXMN
Cj4gICAgYW5kIG1ha2Ugc3VyZSB0aGUgdXNlIGNhc2UgaXMgcHJvcGVybHkgZXhwbGFpbmVkIGlu
IHRoZSBjb21taXQNCj4gICAgbWVzc2FnZS4NCg0KSG93IG11Y2ggY29kZSBkbyB5b3Ugd2FudCB0
byBkdXBsaWNhdGU/IG1hY2hpbmVfY2hlY2tfcG9sbCgpIGlzIH4xMDANCmxpbmVzLCBtb3N0IG9m
IGluIHRoZSByYWN5IHNlY3Rpb24gZnJvbToNCg0KICAgICAgICAgICAgICAgIG0uc3RhdHVzID0g
bWNlX3JkbXNybChtY2FfbXNyX3JlZyhpLCBNQ0FfU1RBVFVTKSk7DQp0bw0KICAgICAgICAgICAg
ICAgIG1jZV93cm1zcmwobWNhX21zcl9yZWcoaSwgTUNBX1NUQVRVUyksIDApOw0KDQpUaGF0IGxv
b2tzIGxpa2UgbG9uZyB0ZXJtIG1haW50ZW5hbmNlIHBhaW4gdG8ga2VlcCB0aGUgQ01DSSBvbi9v
ZmYNCnZlcnNpb25zIGluIHN0ZXAuDQoNCj4gSSBoYXZlIG5vIGNsdWUgd2hhdCAidGhleSBjYW4g
dXNlIHRocmVzaG9sZGluZyB0byBzaWduYWwgVUNOQSB3aXRob3V0DQo+IHNpZ25hbGluZyBhbnkg
Y29ycmVjdGVkIGV2ZW50cyBhbmQgaXQgd29uJ3Qgd29yayB3aXRoIENNQ0kgZW5hYmxlZC4iDQoN
CkkgY2FuJ3QgcGFyc2UgdGhhdCBlaXRoZXIuIE1heWJlIHJvb3RlZCBpbiB0aGUgZmFjdCB0aGF0
IFVDTkEgaWdub3JlcyB0aGUNCnRocmVzaG9sZCBpbiBNQ2lfQ1RMMiAuLi4gYnV0IG1heWJlIHRo
ZXJlJ3Mgc29tZSBtaXNzaW5nIGRlc2NyaXB0aW9uDQpvZiB3aGF0IHRoZSBTTUkgaGFuZGxlciBp
cyBkb2luZy4NCg0KPiBJIHRob3VnaHQgSFAgdXNlIGZpcm13YXJlIGZpcnN0IGFuZCBhbGwgdGhh
dCBtYWdpYyBFRkkgZ3VuayB0byBkbyBSQVMNCj4gYW5kIGRvbid0IHJlbHkgb24gT1MgZmFjaWxp
dGllcy4gT2ggd2VsbC4uLg0KDQpIUEUgYXJlIGJpZyBmYW5zIG9mIGZpcm13YXJlIGZpcnN0IGZv
ciBjb3JyZWN0ZWQgZXJyb3JzLiBJdCdzIG1vcmUgY29tcGxpY2F0ZWQNCmZvciB1bmNvcnJlY3Rl
ZCBvbmVzIGFzIHRoZSBPUyByZWFsbHkgbmVlZHMgdG8ga25vdyBhYm91dCB0aG9zZS4NCg0KLVRv
bnkNCg==
