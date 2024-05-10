Return-Path: <linux-edac+bounces-1041-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E08C2926
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A3B1C21807
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842F17C68;
	Fri, 10 May 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcqW8wgr"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804517C6B;
	Fri, 10 May 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361235; cv=fail; b=QHck58hrMdkwzZm5sDikvo1H6ry4VIdz6MCR4JmmwD31PalFgeBpZVMwgWdMp4gZXrwNQrN5ROoF7eqcELkpDMCRd9Yah0M9+lPToEfRHwSifRDikL7VKSo5WiDaOW5bKabvGEOciDmGiz9cHydwkH7yafUeTMKiKUu+MwvgenU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361235; c=relaxed/simple;
	bh=fDNUjUhBdNG9/yUXtWJ2nSrGF43B1q00SPbVT0y3/6g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MFbdU5WEXWBTKHR7n3ik1Dsi/PEPJ++omgcwB6BKyXnTFXTk4Y94D93LtS7qZoWASbsCtpB/+GElMjkUDcd4M/XaHcovJ44brc40qwUdEORdjWtKEXjO1pLJ8Re3JsAxALKlOdK34LJdiuJGwnjVLdEbpv21c+oki/tePV315ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcqW8wgr; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715361233; x=1746897233;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fDNUjUhBdNG9/yUXtWJ2nSrGF43B1q00SPbVT0y3/6g=;
  b=HcqW8wgrhcYOAcqknJk15+eVg81GnikSBPVSynQj8nwYmKBW2XaJLz/b
   1uM5uOVTBeyMFs88wY3TcRILrFfXmlDoUkf+Y9olrfcTZk2Ebb9yBNlE4
   AenSXCpXwqd4PjC3pF3re5TXeVD1jdbmuFar/lSTWH4sjV6jQRTqOfLnu
   rsqieLjG09S6JH+ZszzXf56T8Cs226lVJMPIZvkDk/4i4+O96dfGcqbwb
   WwAbFJe7UekIwX8gY+pdNap6p1dKxYm8Zi4n+rQMKvOnSLS9UPNfkuiqC
   GzobNcp/ZfgtnzX3h+B+uu+XQr72Pe/xOcWY94wj/QwO74mVsuzIANs5a
   Q==;
X-CSE-ConnectionGUID: GmYO/D3xR9ue33MXwrj9LA==
X-CSE-MsgGUID: jTFYK84hTYOTeQnzgrldDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11183081"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11183081"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 10:13:51 -0700
X-CSE-ConnectionGUID: 8vcxz+o6THSQF2+F64G3pw==
X-CSE-MsgGUID: bS77ArGyQrSW2yGf7LvoSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67164809"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 10:13:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 10:13:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 10:13:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 10:13:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 10:13:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1cvVt/HD6tq4RfvBoy2tqQv5GJc0AB+lWoaBF9w+HMbAJ2u6cStTrSo8MMcs2KVc/qpZnlrzxlecQdP3MqX0drWLi5DvT5dcS/VRtJXHmlbq7Ww+fm84bWKGfNb8Apb0yhgUUa9UJNkS/m6XIxl2UW9806+S/pWNNcUwYt0wc5jXoLnXVWHq/dshTuQjvDiHMYlFfy2Ikxrl3uHK3MtaXHHdUtr3ZXfB/SUNaBSVSxrii216wK5O8yBFcbgAGiOSkSCNVDuCp8YIwrkPawJQrCZyk2W5cLuKr+O+mx/+OgmIu61dSjpElZYYvsgo4/z9ydOrMq3M0ITaUGtHKBKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oof/9s4Si0fgiPfsSFVyeEEHJf4ZTR3BmoidhO9HUWU=;
 b=PD8ubIRXv174eN/3VUpZHlLcs1OFF46pWIv4kE6MsupK742IJhJNLHz3JXLEOojoxTJZHqZEcyZM27XwJc2MVSt+o4LTR8ifCYUubgAPt3levD2hgq8J3epH2lWpYB733akOjKayC1j9l/73AW/L3/rCFv+0qMwxbExhVfH9ca8MJ+hQf47T5IuA1DVWH8WAJhVOVqBiiHcZerrJ8mnxGRluM+wO2FKZ/APJcIBatCyPZ1oSm8XDyMYX+p7ES5FhB1NrodVWwQi4g1bzbL60G+m2TVHFEn1DB+/0A8DwXkVt8MrVd6JX7DEH2stX116L6Phj7nqt2YCtLSKwCPfz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6457.namprd11.prod.outlook.com (2603:10b6:208:3bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 17:13:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 17:13:45 +0000
Date: Fri, 10 May 2024 10:13:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <663e55c59d9d_3d7b429475@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
 <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
 <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
 <20240509101939.0000263a@Huawei.com>
 <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
 <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
 <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
 <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
 <663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240510092511.GBZj3n9ye_BCSepFZy@fat_crate.local>
X-ClientProxiedBy: MW4PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:303:dd::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: f632bc09-df05-49b0-802a-08dc71148cae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lZRtJ6Hl9Q5jj0WimlrncPwUF0uWh48Ouu37/J5rx4gyvYMuQ0FOHTdi6VzX?=
 =?us-ascii?Q?5xK0P4NF9PjO8+c6ZBYMjsSxCQdONxsW8FnxZYiGTO9WhVTBc+yraZxMCzCN?=
 =?us-ascii?Q?vjZYGIMvcPFFMdIH3JqLI986GUg+XuPX8An7Imt/8c1+87HW+sYdh5r8Yrvd?=
 =?us-ascii?Q?btR98XlSlm7rzlXThoyJawW3NbudTW7bwXt/B7veNVJ1XqMtCWQqDaVgJjYY?=
 =?us-ascii?Q?AKr8NemTWO8ng6kXQp2HcpZALmEE8ToSHVoCtBtmt97xVhGDaLTpJ6mZyiju?=
 =?us-ascii?Q?sqrXVrTfKd7lSxJ6CZ6fW9+sAClntcBNjjCkukth9jkAzO6d51RTqR70d67X?=
 =?us-ascii?Q?SmhGd3YLltSdxWu2xhvP7ZoQ7tXo2trIERd9I2Dw5apFT+0WvVyfzK+6ekqm?=
 =?us-ascii?Q?b5KHGCR9Agry/pM+nrxq2psazgAQ/F/RMYSRVOlMxeDiBHTKouUKgqV6Tj1H?=
 =?us-ascii?Q?1knVrAdztjfVpYRb4RWlAR3Fa9/p2O3P7YZqFGKeuJEbkTY0XiJylVC0oKZY?=
 =?us-ascii?Q?MhF9pRIOoLOsiic0cjXk9QL89SjPgkITOeGAacsrlxuujSxwgTP7ukVe24Gm?=
 =?us-ascii?Q?PcY1di5RSaHhEf/j6Vm2u/oBv/Fac6HfbXsffzAyHNBHl4yai/YXn7ocPuBZ?=
 =?us-ascii?Q?k8Vh19wQ+c6YHOseb8dYisU5o+yGWF8AFb1wTJ9GYrYgmFQOnZU5TaSXTTso?=
 =?us-ascii?Q?1dKOYxui0w6g4eVR9n+ZJUIuzAzyX82sJ8f4QM1AbH1DF4VlN357wuEjzfh+?=
 =?us-ascii?Q?5MJiGWhHqhflEe3KXhm5hNCT3AHCQuAc1fS26uu5BlqiMeWpWDqYpQwdVEQz?=
 =?us-ascii?Q?ZMmOIOFAho+s0kN+o3EnihtV+PF1iKAWHmoCIr8w4pNU6ReUWu7qeNuJRsWT?=
 =?us-ascii?Q?Kfp9GtT4XroHTfGgV5NWq9zaggN+C2fswpCXlOrVgclNrFt0y+kAT8+kt7Yp?=
 =?us-ascii?Q?Wf1WMqtqk22POSc9QVzplDL9+Fyu9qbVVb3y8SpQMQSyi/6TRCelBTnqfeH6?=
 =?us-ascii?Q?fUEwbjUf6U5NlV7fN/JxDAtfLAYnVv7l0FO0lxiZCUSjtBeCTWJh2cRSBDRu?=
 =?us-ascii?Q?mhZc3e2eNPDk4hJs4KluVzybcJ09VDxeG72CrHslqdmzoMrZwauUsfy3U7wo?=
 =?us-ascii?Q?4RVE89MfgylzcnrisE1lAEZA13bQJg8Hd29P3RNBHxbmMLURGIxSnwL0BRhu?=
 =?us-ascii?Q?GUVaoP60Lsvv5m3ZgLE+pcoDif3xRUqzM04pVxIPNDqCk0v3lKBh2OuXy8k?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/sP6xoCxtPRFoqXOEmP6yZb5dz0+930KeVuKuwaXXlzuEnwRczPZCjmbGflw?=
 =?us-ascii?Q?7cxUXa8z3zZaWcQ2A94N6DX3Ko16caY1Imn76DNEpWxgbmFFYOpb1Laatp24?=
 =?us-ascii?Q?GBgbVmYHsTNHCerMcNkvBBVQ6eu14TpJ8Xz+MK41ZiA84rB8fmSeNPruZrsF?=
 =?us-ascii?Q?9RqJ67Lu7EHwm0VuZkCdOzS1hap8gsNCClcRAoNr3oEyqh3KPlS5uO176VL/?=
 =?us-ascii?Q?/b39o13ggTXO1jZ1Fe0D8bIBAGwyjA4XN6fndx6y1olMXsl8D37rQznDD918?=
 =?us-ascii?Q?PcqQdNPmrNlApzYQKbH4GSafo/5zmPiM6rEqxsXgXmiFn5/lRhYVeMuHyLwz?=
 =?us-ascii?Q?S1Q+apj6kU6lRNCtyk4zSGdIOw5rm8oi3fUtb672ul9oEs3hVjaj6T2mQg63?=
 =?us-ascii?Q?Kul0xIa7Mj85rjZPFOIw2JoxBqMqO75BOGdMNVcE7oecjInRzvoZRMG8iu/e?=
 =?us-ascii?Q?zUBq7oYl1HcYeoJCtM6FiDk009PtzgbB1UttvaqlaccQ5jYb0tzZ/TEGUJZh?=
 =?us-ascii?Q?qEDBULznzl9YxGa9UlzFYZjRvCbdDy7woRyk3oFZ3yK1CFiRxQTpvNFI2Jas?=
 =?us-ascii?Q?c4xGWkq/OTEzuDGtC3uFANH27CXDdh7AXNH4Xuylt0nRYJXR1t7N6z8UXqxb?=
 =?us-ascii?Q?HuQhKWPWHNx01UTksN+rzz7PsqDe53W1YwcSTeP55DC0Tkj+vYNjL8uWQZzO?=
 =?us-ascii?Q?oj56FMKQmmg2gSc39pwuJ/pZRVfLiEkaalIQzYLw6mDUjQMg00xXU3RHAy8T?=
 =?us-ascii?Q?utl3UNGkVBwFtMNOgzFZumVukgerKQucUVVWwWFlA1JI5vZDd5RVyLm3tmJQ?=
 =?us-ascii?Q?apAxK4U2le20tRhXNYIsOXdj4nfiyLBGWx4KifmC4uV1hzxArfRsXoJ/DnaI?=
 =?us-ascii?Q?zZeOgmwChLvz9I+NkC0enoWYT+RCGZp+8zoK3phDG3ukoaJX9DcDg6+LwcoY?=
 =?us-ascii?Q?X+sJPG282bZnWFqBDoXG4WuXmFw4kv4hPO5eFxiDkxPx257mnKFc9HrJsCI5?=
 =?us-ascii?Q?EibwPskCwNW8NiKF0C1UHmVrmYOEDLa4dJ5Or5reTrf+1Ugw5Spaf7gmpOv0?=
 =?us-ascii?Q?hW7lQr5ZSUm4wU7wuCyrWo9UB2IMtkNQKaPAijmSvxDcMxYoVlRwXPj+l8nk?=
 =?us-ascii?Q?KmKFE3vho3KmXc0rRC+il7wSRGwzyj8JjWZ69Z9WyTnt5G2NuZhDymZDZDvW?=
 =?us-ascii?Q?RdCMMnbhiDf27751H4PZdzEJ2sGDaY03vVJuPQS2n05b5dY0Z0OsGPoLYCUl?=
 =?us-ascii?Q?K4xQ0OR+2G4ioehZ1QwM1GJyhvCU6hMTWkfe0vWEcrFwRCkf5PrW/KgaENZN?=
 =?us-ascii?Q?uH6BVTw4hDTysFOM+UN/o/XWUHFiM5TU3hrAzZT5olQX2RaXYG0wEtr5pm4+?=
 =?us-ascii?Q?qRhKVt1ltnn9kFedIR6F8w6FRtZ4XUOeztACCeM3qWJ1226st0ToVtz4qXwd?=
 =?us-ascii?Q?3+iMqIyjkQIep+jo8nur+ikdkMvc8HgmsTD5qSw+OyZN2oyMo6//kIgHFGkE?=
 =?us-ascii?Q?RznwUWqRuCFNsa5J/qunIi/zNLFwMCbgepSnrQD7eKjOTKUGsf6ppyMVhgSW?=
 =?us-ascii?Q?4PjBCu0RQBxq/3m7R4VMeh3KV4uYDwdhi6fOtbypLZ2KcdOddsdZX6xSBjl9?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f632bc09-df05-49b0-802a-08dc71148cae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 17:13:45.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb9hopLlaylbhNY5hZ0EzWk/ZAHGmGJ+X9RRPcYncNN50cgn3RWKAK40szLD84wr/Hs6zZQHaKsA0FxfTdgEg5OJli8z8alf8ljJaRosois=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6457
X-OriginatorOrg: intel.com

Borislav Petkov wrote:
> On Thu, May 09, 2024 at 03:59:29PM -0700, Dan Williams wrote:
> > No, at a minimum that's a layering violation. This is a generic library
> > facility that should not care if it is being called for a CXL device or
> > an ACPI device.
> 
> Really?

Yes.

> Because this looks like creating a subsystem for those two newfangled
> scrubbing functionalities which will be present in CXL devices and
> by that ACPI RAS2 thing.
> 
> Because we have a *lot* of hw scrubbing functionality already. Just do:
> 
> git grep "scrub"
> 
> Some of it controls hw scrubbing. If this is a generic facility, does
> this mean that all those older scrubbers should be converted to it?
> 
> Or is this thing going to support only new stuff? I.e., we want to
> disable our scrubbers when doing performance-sensitive workloads and
> reenable them after that but we don't care about old systems?
> 
> And all that other bla about controlling scrubbers from userspace.
> 
> So which is it?

In fact this question matches my reaction to the last posting [1], and
led to a much improved cover letter and the "Comparison of scrubbing
features". To your point there are scrub capabilities already in the
kernel and we would need to make a decision about what to do about them.
I called out NVDIMM ARS as one example and am open to exploring
converting that to the common scrub ABI, but not block this proposal in
the meantime.

For me the proposal can be boiled down to, "here we (kernel community)
are again with 2 new scrub interfaces to add to the kernel. Lets step
back, define a common ABI for ACPI RAS 2 and CXL to stop the
proliferation of scrub ABIs, and then make a decision about when/whether
to integrate legacy scrub facilities into this new interface".

[1]: http://lore.kernel.org/r/65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch

> > I think it works for x86 drivers because the functionality in those
> > modules is wholly contained within that one module. This scrub module is
> > a service library for other modules.
> 
> Well, you have that thing in EDAC. edac_core.ko is that service module
> and the chipset-specific drivers - at least on x86 - use a match_id to
> load only on the systems they should load on.

Which is exactly the same mechanism being defined here. scrub_core.ko is
a service module that would only be requested by an ACPI module or a CXL
module after one of those loads based on their match_id.

> If I had a BIOS table which had "EDAC" in it, I won't load edac_core.ko
> either but there isn't one.
> 
> > It is functionally the wrong place to do the check. When module_init()
> > fails it causes not only the current module to be unloaded but any
> > dependent modules will also fail to load.
> 
> See above. I'm under the assumption that this is using two methods to
> detect scrubbing functionality.

The scrub_core, like edac_core, has no method to detect scrubbing
facility, it is simply a passive library waiting for the first
scrub_device_register() call.

> > Let's take an example of the CXL driver wanting to register with this
> > scrub interface to support the capability that *might* be available on
> > some CXL devices. The cxl_pci.ko module, that houses cxl_pci_driver,
> > grows a call to scrub_device_register(). That scrub_device_register()
> > call is statically present in cxl_pci.ko so that when cxl_pci.ko loads
> > symbol resolution requires scrub.ko to load.
> > 
> > Neither of those modules (cxl_pci.ko or scrub.ko) load automatically.
> > Either udev loads cxl_pci.ko because it sees a device that matches
> > cxl_mem_pci_tbl, or the user manually insmods those modules because they
> > think they know better. No memory wasted unless the user explicitly asks
> > for memory to be wasted.
> 
> The scrub.ko goes and asks the system: "Do you have a CXL device with
> scrubbing functionality?" "Yes: load." "No: ok, won't."

Yeah, that's backwards. CXL enumeration belongs in the CXL driver and
the CXL driver is fully responsible for deciding when to incur the costs
of loading scrub_core.

> > If no CXL devices in the system have scrub capabilities, great, then
> > scrub_device_register() will never be called.
> > 
> > Now, if memory_scrub_control_init() did its own awkward and redundant
> > CXL scan, and fails with "no CXL scrub capable devices found" it would
> > not only block scrub.ko from loading, but also cxl_pci.ko since
> > cxl_pci.ko needs to resolve that symbol to load.
> 
> Why would it fail the scan?

cxl_pci.ko loads based on match_id and cxl_pci_probe() enumerates device
capabilities. My interpretation of your feedback is that
memory_scrub_control_init() should duplicate that cxl_pci_probe()
enumeration?

Assume that it does and memory_scrub_control_init() finds no scrub
facilities in any CXL devices and fails memory_scrub_control_init(). Any
module that links to scrub_device_register() will also fail to load
because module symbol resolution depends on all modules completing init.

> Isn't this fancy GET_SUPPORTED_FEATURES command giving you all info you
> need?

Sure, but that's a driver-probe-time facility, not a module_init-time
facility.

> > Lastly I think drivers based on ACPI tables are awkward. They really
> > need to have an ACPI device to attach so that typical automatic Linux
> > module loading machinery can be used. The fact this function is a
> > subsys_initcall() is a red-flag since nothing should be depending on the
> > load order of a little driver to control scrub parameters.
> 
> Yeah, it is becoming a mess before it has even started.

I assume you do not consider edac_core a mess?

Now, the question of how many legacy scrub interfaces should be
considered in this design out of the gate is a worthwhile discussion. I
am encouraged that this ABI is at least trying to handle more than 1
backend, which makes me feel better that adding a 3rd and 4th might not
be prohibitive.

> So I don't mind if such drivers get loaded as long as doing this is the
> best we can do given the situation. What gets me up the palms, as they
> say in .de, is "just because" and "look, the others do it too."

Which matches what I reacted to on the last posting:

   "Maybe it is self evident to others, but for me there is little in these
    changelogs besides 'mechanism exists, enable it'"

...and to me that feedback was taken to heart with much improved
changelogs in this new posting.

This init time feature probing discussion feels like it was born from a
micommunication / misunderstanding.

