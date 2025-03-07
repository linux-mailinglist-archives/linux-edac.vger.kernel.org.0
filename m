Return-Path: <linux-edac+bounces-3294-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A6AA55D35
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 02:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67AC16AAE2
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 01:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212CE1552E3;
	Fri,  7 Mar 2025 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpP1uT3t"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29A18027;
	Fri,  7 Mar 2025 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311568; cv=fail; b=lEvpVfT9TxP8yqVyTmGofomDJiUX0MhODJ0OpLxX2S7Kn4j4609FPqDH+GqSunbIenH5xTylJbuFd+muXy7bVCFVeD8k10mxetBAU/VvUh44es1e51IjclneSVezDi5MxdCPLiowuxFU8nHXQnyM1koqlQ6Vm6RaCQ1bSORxveo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311568; c=relaxed/simple;
	bh=EUZ6q8SzZw7OcmOPHJhdZ7ixhTzh0bjd8nKxSRi7P6o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QHD98LFZh8a5kqZBDAu6LdYGCXzCSGlc9te6a4EWGOM/hdwwcdxkp2YsCFq+PiWw9GfkvG0wYnoGVPlCXXfZCmq4kopM1Ppus3owwq4iBa23SgN4l6qtOt1dgcjgyzvfK/oKWMaRPyRHaYN1+QfkWCenWZTEiROvTvZ4mT+KWWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpP1uT3t; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741311565; x=1772847565;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EUZ6q8SzZw7OcmOPHJhdZ7ixhTzh0bjd8nKxSRi7P6o=;
  b=FpP1uT3tv1nogOyy1aZW7nwE+hkSuIYBFtcwE3/7rL9CMoo3F8p7otKZ
   dpE6ZQsgi8FZEbxN4MWo7WW8zwwGNJn8gj5eTTzFzTk4aCow2+fUHIRfO
   mFP2vKXnyEIqTOZVGD4b4o7yh2eSkYAYD5xdWcxQEpcJlQxT7SjobQwWC
   akJO97mgqiasQhR2ACkDv4ek/BnplxkZqPiN3QfoTnKnC9ldCNdXl4hie
   Yl6VskguKIhc5VxckQNXvduTzAK7DmztYRPpledRXVQ5ldCvqqW6WXiIl
   /XG4gQkjOi5FGi/4xOpM+EkUpUHrZzfQr1vuD0wrS4fzpkyHQ762syFne
   g==;
X-CSE-ConnectionGUID: bRgSXRoaTkW2jzfoLshbCA==
X-CSE-MsgGUID: ohsynKygRf6hFKPQp2/Qdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46004042"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="46004042"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 17:39:24 -0800
X-CSE-ConnectionGUID: qyV/0T0bTDK7HOzIqUfCag==
X-CSE-MsgGUID: 2Ymv8x53TDS4QQwLv62m3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123380646"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 17:39:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 17:39:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 17:39:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 17:39:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDS76JKLAhiwInddP+fKCv6WlqG38hwUnGdh77krIO0nwweHDYd5epOaUQ865xdzSMRbkNsbeFdzAkqThe7w1WS9ey5V4pfaMmNdFny0d+mDpLZeeP8r7jiLsmMvRUhe1UKNRmiB5sOUuM1aI8wq3hHO+v2V7E4SklNiLdwRc7w0iqJ5HOw4PBRXUU0f8u/bY+GUxIkTAoHL+CdQIuKna5hTFwztxa4prikbSekNr4XzvQ34WhxL1giY9CHDBEzr/uzm+PBbfN5WAR4nf50h1LvvoKpDBoyrnG73RTDDJu7cJpUqp3m6H4Bly1Zu740HevK2BrYgFI6JMf+tqEqdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA24RBbCMdMmiKgf/8lI6Cubq/Aj1H1e6t+kJKr7fG0=;
 b=NbPluI7MNYb39C/7YLUae5S03jqB0dZnC9WgwSal/AqurLxRo2dNlT8eRHQa/9iJGpR9HA+Ki7K2bCItxarTyd0BUgCQlWNh+SrOj50n/YM7OtcFFm9ad0k+LPxmBKqDUhQIk5LvIMmGDzXzHlwQyFLx6liOkx1gJkGPaJaFP0L3Uliqx+bOTvqZM8k0JWR6JrxqCyMnKwJ80br9HJ9j3E+VDXnb8Vr9IOJo4LjGoSWPFcaBEHeY0QRKeS5X95KQQE3B2+2UGoJ7l2+bEHFTTBEVgD3mKMr62BgxHbvBPMqziG15G6h1/71wrfoLXZErqHInSrp/gbFwlGKUU1chJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7298.namprd11.prod.outlook.com (2603:10b6:610:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 01:39:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 01:39:17 +0000
Date: Thu, 6 Mar 2025 17:39:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH 2/8] cxl/memfeature: Add CXL memory device patrol scrub
 control feature
Message-ID: <67ca4e40d7be4_1a7f2942e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250227223816.2036-3-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:303:16d::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed6140e-df98-4ef3-0064-08dd5d18dfd2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Uy23OPOIExFHChLWklaqe0sqxsKADbO2oEdhbyuFL9LkzEP5SvoM9QVXcPZ?=
 =?us-ascii?Q?1HFl68vfXrqPHOzrpztX3xIWRFQhrM+XrO4iCTID6Tij6ODxjoWg2y8u2Vhe?=
 =?us-ascii?Q?n6PoTDmA8s67gXU9AvkdcAPPeRD0sZKvh+rcEGFnJx2IiMMRcz4UdOrEtjeK?=
 =?us-ascii?Q?rdIrB0uRoYQoc9UhnMxO5QG9rDm+H9kGFNCsnS9hCLKZmM6LiCR7m5wCvrbx?=
 =?us-ascii?Q?LBz08SO5G43ydeV4ieTvsT80oaDLb1z+lbaApwIckSJRKIgM1nJbi/DxIQh2?=
 =?us-ascii?Q?yiwYXkrk4lGiKqxMYnx3xOtBhUWo8Z2pPLNsFLMcvL1enJVeidQNgyzE2kMf?=
 =?us-ascii?Q?DWer5vJ5hwDbaeKQh0Hqc4ND0zix/3B3BU3yuoUXyE2xJgukO8vx3IKgzIfV?=
 =?us-ascii?Q?0IVjA9OFkcgKlVIFglzOOLmZFOpFFWALfRVrGBt+1NBqRODzGrdl3yZwonZa?=
 =?us-ascii?Q?d94l5ifFv4CZHlAWxJGfIApmbRIM4Nmm2qLzoRoHuQSCf9itjV8JhjYDk+Uu?=
 =?us-ascii?Q?UtWUzdMWMroqfWPtPNLPLk7mZtoVWWIaGwzbfclQDghOmOQIQrSAT5MwH5+G?=
 =?us-ascii?Q?2Y09lX3MHVFapP4+gRAmf9z2xsL1xsTmKa2iOfb1mZWb1AZJzBGEmIB92wVv?=
 =?us-ascii?Q?K7oOjYeQgSkQD7VX99kfqMTEWTRLLOuZ7HilT9zieq9RfdNsPRUj5kqO7NpQ?=
 =?us-ascii?Q?1xpoLMFXXa9bTBxZRWx3YnlGiOjoRaerOyb91eSlPwiUu1Mf7GWd2AmdhVTO?=
 =?us-ascii?Q?Se8lt3tS2yzAWwmkeOhG+YNdi0Fag+5P8eqcswxtMHLuj1iCzxQHwIA43rm4?=
 =?us-ascii?Q?nZ0EW0rUm0OoJAZYPoiNtmq7EEjb/lUY58XC8dkAErfPYOGo6dzXF7fyjYwE?=
 =?us-ascii?Q?gdNYjCVW+2KSwJmwdTRjs68zxsVA1ppfN9ZEq83bcIX0sCYyhsi0cAFxK8aI?=
 =?us-ascii?Q?RdhudyLIYT+QhDQLQ4kL1aiWrI79r0omFBOqIGOm0p1uH4YevfZRRmQgR4Av?=
 =?us-ascii?Q?IhyYSO0eG6RQOSsAOTnKXpr3OuDd8Ax+9fmp3wzZtYWgFvYZ+fzIGh1AsGkO?=
 =?us-ascii?Q?jz8pYBHeSNiLx1xyNzS3EuNevOBdt2S/xuxqmbxJcGjoS8jTTPqz/LB8fcej?=
 =?us-ascii?Q?EpM1dVbSiFWnA7T2A3RqTIEqOzUZfx/dUBoHYWPkgtVGFcBgfVQKxGKbDSsf?=
 =?us-ascii?Q?ak/I/G8LtEII3D8fN6E4k+KGqGRdqv3okObAojXAsCkkGL6KLGzGJuqbjrH0?=
 =?us-ascii?Q?eP2FoOUZ1Arstnlb+rp2epnpXN7WF7xyfEgKssN/u8DK27v1l3XaCP74tkDU?=
 =?us-ascii?Q?P/zESwXDeqi5eSdqLhyELR2CxWXY7jNkeGUifNlyW5G98T02lryjGIPiCFIB?=
 =?us-ascii?Q?3sBg3awZNCWa2Ly7io4lzFOvNFglL11d76UNG78KAdnCZuVdheqBKcnTqv//?=
 =?us-ascii?Q?iEXyIXf+77o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iF2ntReE2q752Lh5YoTQZ9nWVX/VWroCqDGBtyFth49wjNbNL4hxI3WNnWF7?=
 =?us-ascii?Q?ddPvTSXlM6leg6yPhtv/G2x8zoq+82RAZfy3oHZsr/qwFMR6PSqN0f7bGAia?=
 =?us-ascii?Q?MJ4cFx0B2vjpd/NZlYU6pTszNxVbFqMnytlUvqs33FoorHJ/7vXbWo3GTmSo?=
 =?us-ascii?Q?ub9avQAbLdBhgxHEcF3WKRZPYSFB2lKYmz1MHUoiHZ8IM45KMt/j9wy1pPLT?=
 =?us-ascii?Q?Qmpo8JkDjw3jpWFhkHDCtNsjzhbX5RYpkTKeNk9jnDMeRKeHJj8H7GpZshZ1?=
 =?us-ascii?Q?BeYZiagXiCG7jwY0mxDOG77lWhI9enRitS8ZJfeERmsZm6d941QZYeHFM0xj?=
 =?us-ascii?Q?5bNNKaY5GbRWXrHj/CzJRQtCoH6aaZh1cW8FR4+92ygXVkDiiGkSTVAry0Pk?=
 =?us-ascii?Q?0tiLkY1wNUO7/1G7E6rSVv2pJOyz5Fi0gvLvFOPnV3LwC/HwdjXELtLXBJ3G?=
 =?us-ascii?Q?xRKfsy1bJHnCVBmlXXXUnRWg5nVdQqa0lgam3OyVoTzLCSUAsz3uaLRIJ76f?=
 =?us-ascii?Q?2iu9ZR+e18QTd1iFYztdRcAsy0Np676ZwGYbQIeQOC43OWz2g/ZSQhhaeeVU?=
 =?us-ascii?Q?1BE1rTq2n14lCvSCX+nBwFoadU6N19MOJfu8XuhOGR/hY3kqzi3TSJAZ2FWJ?=
 =?us-ascii?Q?6ZFXr60z+BcdnPcE7YU8jORJWY1jx2MALqH7B7zORS6d5QPsAQesKKDeLmz8?=
 =?us-ascii?Q?JPL6ZgBnGIsVsGZwUu22gWRGx2Iu7v6HPB1OwnmMSb63SQR4oAxYaGcLyUQS?=
 =?us-ascii?Q?5Tv5pywYhBHyRSTvfqgB4sjlb5W3gpbUmuu4qnG8Vm3SpVqUO2RZnfdNQjCC?=
 =?us-ascii?Q?vdkl9whafaGfBtIQ0hUo1Epa8Egsmu86PLJq7NKuaA7V1j0IqHw+TYuQVAH4?=
 =?us-ascii?Q?jB19svdic3ighCd/YxBeEK4h1Afvmxtj/eQuIUOO6uegTb9RHMx7xtY1wFVT?=
 =?us-ascii?Q?Qul38anT5RP3tnPKb0d5pmRxgInOUDYOx07vSjBsTC72Xa0iHsm9XKC4h5pm?=
 =?us-ascii?Q?MCmIFnkDwrP5fsx2JaFoa8bC19ABPlaraEx9veej1puEa985fDbjI7txGFtP?=
 =?us-ascii?Q?zi8RR4XnUiHJfVsKnOOaGAQeMnAHLTyjjj4nbsrDsMpmz5GNipGfqDvJsSGW?=
 =?us-ascii?Q?ALF4+PuDJ3zHSBB5ka78CR7szH2UiocyWv0J+KvKE6KlVQoDnsN8kjH/uWUd?=
 =?us-ascii?Q?BC57h7HalG0lFvNd/k/YlQsJHL6Vx8vKQcIdjlHWht0MOrWh44VnTbiCbm4B?=
 =?us-ascii?Q?Q6r4EhZxtJSrW/0aQ5Guz38Aj6vXkRrjkbWKaMIeyZOw86xiOsyMx0L1xdom?=
 =?us-ascii?Q?vFR2Mgf3ZhynVuW9aNTqr7bfGZcRTW60Yo8EPe+N1HTl5zMk4CaOgc8pMCtb?=
 =?us-ascii?Q?/SgPb0Y4nmkybgGbYRxVXKxbQpXo2ax5KOJdwtfsv6vHh2e/oToQ+Y4+Arw+?=
 =?us-ascii?Q?+PtxiHqvMWz4xl/u7t51kXrld3c1/Mt/8aYzliZxvM0wkKrHLaEHpDJBwm+S?=
 =?us-ascii?Q?pmO4Ivrm3aFV21WkH8I/N/7Cs1znmdgnzRQl8H96GeFbOsPyuqJ4Rc6PMZek?=
 =?us-ascii?Q?Y5scJWfRmj1ROyFngMaCxml1WQHRcniM189MgXocoQ0078lTUKps5MhXbS1I?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed6140e-df98-4ef3-0064-08dd5d18dfd2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 01:39:17.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2h6KRcn5VV7vh9BGO/iVDL9zHM5Sb6Oxs1yUaxAliXuLIdfr3agcjz2ZOAvEm6cr3ReUPKCqRLjl/jgO7MEjDnmF82ySM9W8QskNWZPOYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7298
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
> control feature. The device patrol scrub proactively locates and makes
> corrections to errors in regular cycle.
> 
> Allow specifying the number of hours within which the patrol scrub must be
> completed, subject to minimum and maximum limits reported by the device.
> Also allow disabling scrub allowing trade-off error rates against
> performance.
> 
> Add support for patrol scrub control on CXL memory devices.
> Register with the EDAC device driver, which retrieves the scrub attribute
> descriptors from EDAC scrub and exposes the sysfs scrub control attributes
> to userspace. For example, scrub control for the CXL memory device
> "cxl_mem0" is exposed in /sys/bus/edac/devices/cxl_mem0/scrubX/.
> 
> Additionally, add support for region-based CXL memory patrol scrub control.
> CXL memory regions may be interleaved across one or more CXL memory
> devices. For example, region-based scrub control for "cxl_region1" is
> exposed in /sys/bus/edac/devices/cxl_region1/scrubX/.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  Documentation/edac/scrub.rst   |  64 +++++
>  drivers/cxl/Kconfig            |  18 ++
>  drivers/cxl/core/Makefile      |   1 +
>  drivers/cxl/core/memfeatures.c | 476 +++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c      |   5 +
>  drivers/cxl/cxlmem.h           |  10 +
>  drivers/cxl/mem.c              |   4 +
>  7 files changed, 578 insertions(+)
>  create mode 100644 drivers/cxl/core/memfeatures.c
> 
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index daab929cdba1..788cf43188a4 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -264,3 +264,67 @@ Sysfs files are documented in
>  `Documentation/ABI/testing/sysfs-edac-scrub`
>  
>  `Documentation/ABI/testing/sysfs-edac-ecs`
> +
> +Examples
> +--------
> +
> +The usage takes the form shown in these examples:
> +
> +1. CXL memory device patrol scrubber
> +
> +1.1 Device based scrubbing
> +
> +1.1.1. Query what is device default/current scrub cycle setting.
> +
> +# cat /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +
> +43200
> +
> +1.1.2. Query the range of device supported scrub cycle.
> +
> +# cat /sys/bus/edac/devices/cxl_mem0/scrub0/min_cycle_duration
> +
> +3600
> +
> +# cat /sys/bus/edac/devices/cxl_mem0/scrub0/max_cycle_duration
> +
> +918000
> +
> +1.1.3. Program scrubbing for a device to repeat every 21600 seconds (quarter of a day).
> +
> +# echo 21600 > /sys/bus/edac/devices/cxl_mem0/scrub0/current_cycle_duration
> +
> +# echo 1 > /sys/bus/edac/devices/cxl_mem0/scrub0/enable_background

Like I said before, I find documentation like the above to be pure
noise. Please drop the echo and cat demos,
Documentation/ABI/testing/sysfs-edac-scrub is sufficient.

> +
> +1.2. Region based scrubbing

Yay, actual content!

> +
> +CXL memory is exposed to memory management subsystem and ultimately userspace
> +via CXL regions.  These can incorporate one or more parts of multiple CXL
> +Type 3 devices with traffic interleaved across them. The user may want to

s/Type 3/memory expander/ or "memory device", as even the specification
is getting away from "Type" language which only long time CXL
specification experts understand, not end users.

> +control the scrub rate via this more abstract region instead of having to
> +figure out the constituent devices and program them separately. The scrub
> +rate for each device covers the whole device. Thus if multiple regions use
> +parts of that device then requests for scrubbing of other regions may result
> +in a higher scrub rate than requested for this specific region.

Does the base EDAC documentation also talk about this conflict when a
device's scrub rate can be affected by aggregation objects? Or, is
aggregation a CXL specific interface phenomenon?

Questions I imagine an administrator would want the documentation to
answer are: What is the precedence if someone sets the region scrub rate
and then the device? How does changing the device scrub rate affect the
region rate? How does changing the scrub rate for a region affect the
scrub rate for other regions on the same device?

The documentation should be sufficient to write a tool such that someone
would not get surprised by the multiple-regions per-device case.

> +1.2.1 Query what is device default/current scrub cycle setting for a CXL memory region.
> +
> +# cat /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration
> +
> +86400
> +
> +1.2.2 Query the range of device supported scrub cycle for a CXL memory region.
> +
> +# cat /sys/bus/edac/devices/cxl_region0/scrub0/min_cycle_duration
> +
> +3600
> +
> +# cat /sys/bus/edac/devices/cxl_region0/scrub0/max_cycle_duration
> +
> +918000
> +
> +1.2.3 Program scrubbing for a region to repeat every 43200 seconds (half a day)
> +
> +# echo  43200 > /sys/bus/edac/devices/cxl_region0/scrub0/current_cycle_duration

More noise to trim. Replace it with a cross reference back to
Documentation/ABI/testing/sysfs-edac-scrub.

> +
> +# echo 1 > /sys/bus/edac/devices/cxl_region0/scrub0/enable_background
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 205547e5543a..b83bdb30b702 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -113,6 +113,24 @@ config CXL_FEATURES
>  
>  	  If unsure say 'n'
>  
> +config CXL_RAS_FEATURES
> +	bool "CXL: Memory RAS features"

The CXL subsystem enables "RAS Features" outside of this new enabling.
Just name this what it is, the CXL wrapper around the EDAC_SCRUB core =>
config CXL_EDAC_SCRUB.

> +	depends on CXL_MEM
> +	depends on CXL_FEATURES
> +	depends on EDAC=y || (CXL_BUS=m && EDAC=m)

A shorter way of saying this I believe is "depends on EDAC >= CXL_BUS"

> +	depends on EDAC_SCRUB
> +	help
> +	  The CXL memory RAS feature control is optional and allows host to
> +	  control the RAS features configurations of CXL Type 3 devices.

s/RAS feature/scrub/ or "scrub + repair"

s/Type 3/memory expander/

> +	  It registers with the EDAC device subsystem to expose control

I don't think an end user cares that "it registers". I would say
something like

"When enabled 'cxl_mem' and 'cxl_region' EDAC devices are published with
scrub control attributes as described by
Documentation/ABI/testing/sysfs-edac-scrub"

> +	  attributes of CXL memory device's RAS features to the user.
> +	  It provides interface functions to support configuring the CXL
> +	  memory device's RAS features.
> +	  Say 'y/m' if you have an expert need to change default settings

depends on EXPERT?

> +	  of a memory RAS feature established by the platform/device (eg.
> +	  scrub rates for the patrol scrub feature). otherwise say 'n'.
> +
>  config CXL_PORT
>  	default CXL_BUS
>  	tristate
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index e1d591e52d4b..2f48845b86d7 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -18,4 +18,5 @@ cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
> +cxl_core-$(CONFIG_CXL_RAS_FEATURES) += memfeatures.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
> diff --git a/drivers/cxl/core/memfeatures.c b/drivers/cxl/core/memfeatures.c
> new file mode 100644
> index 000000000000..7a5c0645a07e
> --- /dev/null
> +++ b/drivers/cxl/core/memfeatures.c

Perhaps edac.c?

> @@ -0,0 +1,476 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * CXL memory RAS feature driver.
> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited.
> + *
> + *  - Supports functions to configure RAS features of the
> + *    CXL memory devices.
> + *  - Registers with the EDAC device subsystem driver to expose
> + *    the features sysfs attributes to the user for configuring
> + *    CXL memory RAS feature.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/edac.h>
> +#include <linux/limits.h>
> +#include <cxl/features.h>
> +#include <cxl.h>
> +#include <cxlmem.h>
> +#include "core.h"
> +
> +#define CXL_DEV_NUM_RAS_FEATURES	1

This name tells me nothing about its purpose.

#define CXL_NR_EDAC_DEV_FEATURE 1

...matches its usage.

> +#define CXL_DEV_HOUR_IN_SECS	3600

Just drop this and write 3600, that is actually clearer than this
define.

> +
> +#define CXL_DEV_NAME_LEN	128

See below, just use asprintf.

> +
> +static int cxl_hold_region_and_dpa(void)
> +{
> +	int rc;
> +
> +	rc = down_read_interruptible(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	if (rc) {
> +		up_read(&cxl_region_rwsem);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cxl_release_region_and_dpa(void)
> +{
> +	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
> +}
> +
> +/*
> + * CXL memory patrol scrub control functions
> + */
> +struct cxl_patrol_scrub_context {
> +	u8 instance;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	u8 get_version;
> +	u8 set_version;
> +	u16 effects;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_region *cxlr;
> +};
> +
> +/**
> + * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data structure.
> + * @enable:     [IN & OUT] enable(1)/disable(0) patrol scrub.
> + * @scrub_cycle_changeable: [OUT] scrub cycle attribute of patrol scrub is changeable.
> + * @scrub_cycle_hrs:    [IN] Requested patrol scrub cycle in hours.
> + *                      [OUT] Current patrol scrub cycle in hours.
> + * @min_scrub_cycle_hrs:[OUT] minimum patrol scrub cycle in hours supported.
> + */
> +struct cxl_memdev_ps_params {
> +	bool enable;
> +	bool scrub_cycle_changeable;
> +	u8 scrub_cycle_hrs;
> +	u8 min_scrub_cycle_hrs;
> +};
> +
> +enum cxl_scrub_param {
> +	CXL_PS_PARAM_ENABLE,
> +	CXL_PS_PARAM_SCRUB_CYCLE,
> +};
> +
> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
> +#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
> +#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
> +#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-222 Device Patrol Scrub Control
> + * Feature Readable Attributes.
> + */
> +struct cxl_memdev_ps_rd_attrs {
> +	u8 scrub_cycle_cap;
> +	__le16 scrub_cycle_hrs;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-223 Device Patrol Scrub Control
> + * Feature Writable Attributes.
> + */
> +struct cxl_memdev_ps_wr_attrs {
> +	u8 scrub_cycle_hrs;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +static int cxl_mem_ps_get_attrs(struct cxl_mailbox *cxl_mbox,
> +				struct cxl_memdev_ps_params *params)
> +{
> +	size_t rd_data_size = sizeof(struct cxl_memdev_ps_rd_attrs);
> +	u16 scrub_cycle_hrs;
> +	size_t data_size;
> +	struct cxl_memdev_ps_rd_attrs *rd_attrs __free(kfree) =
> +		kzalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +				    rd_attrs, rd_data_size, 0, NULL);
> +	if (!data_size)
> +		return -EIO;
> +
> +	params->scrub_cycle_changeable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
> +						   rd_attrs->scrub_cycle_cap);
> +	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +				   rd_attrs->scrub_flags);
> +	scrub_cycle_hrs = le16_to_cpu(rd_attrs->scrub_cycle_hrs);
> +	params->scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +					    scrub_cycle_hrs);
> +	params->min_scrub_cycle_hrs = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
> +						scrub_cycle_hrs);
> +
> +	return 0;
> +}
> +
> +static int cxl_ps_get_attrs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +			    struct cxl_memdev_ps_params *params)
> +{
> +	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_memdev *cxlmd;
> +	u16 min_scrub_cycle = 0;
> +	int i, ret;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		ret = cxl_hold_region_and_dpa();
> +		if (ret)
> +			return ret;
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {

Ok, the region lock is needed to hold the cxl_region_params consistent,
but why is the dpa lock needed?

> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +			ret = cxl_mem_ps_get_attrs(cxl_mbox, params);
> +			if (ret)
> +				return ret;

missing unlock?

I am not a fan of cxl_hold_region_and_dpa() giving the locks private
names just for this file.

You can do something like:

struct rw_semaphore *region_lock __free(cxl_unlock) = cxl_acquire(&cxl_region_rwsem);
if (!region_lock)
	return -EINTR;

...where cxl_acquire does the conditional acquisition, and we do not need
to audit for more missing unlock calls. As is, this
cxl_hold_region_and_dpa() proposal injures the ability to grep for
cxl_region_rwsem and be taken directly acquisition sites.

> +
> +			if (params->min_scrub_cycle_hrs > min_scrub_cycle)
> +				min_scrub_cycle = params->min_scrub_cycle_hrs;
> +		}
> +		cxl_release_region_and_dpa();
> +
> +		params->min_scrub_cycle_hrs = min_scrub_cycle;
> +		return 0;
> +	}
> +	cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
> +
> +	return cxl_mem_ps_get_attrs(cxl_mbox, params);
> +}
> +
> +static int cxl_mem_ps_set_attrs(struct device *dev,
> +				struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +				struct cxl_mailbox *cxl_mbox,
> +				struct cxl_memdev_ps_params *params,
> +				enum cxl_scrub_param param_type)
> +{
> +	struct cxl_memdev_ps_wr_attrs wr_attrs;
> +	struct cxl_memdev_ps_params rd_params;
> +	int ret;
> +
> +	ret = cxl_mem_ps_get_attrs(cxl_mbox, &rd_params);
> +	if (ret) {
> +		dev_dbg(dev, "Get cxlmemdev patrol scrub params failed ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	switch (param_type) {
> +	case CXL_PS_PARAM_ENABLE:
> +		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						  params->enable);
> +		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      rd_params.scrub_cycle_hrs);
> +		break;
> +	case CXL_PS_PARAM_SCRUB_CYCLE:
> +		if (params->scrub_cycle_hrs < rd_params.min_scrub_cycle_hrs) {
> +			dev_dbg(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
> +				params->scrub_cycle_hrs);
> +			dev_dbg(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
> +				rd_params.min_scrub_cycle_hrs);
> +			return -EINVAL;
> +		}
> +		wr_attrs.scrub_cycle_hrs = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      params->scrub_cycle_hrs);
> +		wr_attrs.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						  rd_params.enable);
> +		break;
> +	}
> +
> +	ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> +			      cxl_ps_ctx->set_version,
> +			      &wr_attrs, sizeof(wr_attrs),
> +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
> +			      0, NULL);
> +	if (ret) {
> +		dev_dbg(dev, "CXL patrol scrub set feature failed ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_ps_set_attrs(struct device *dev,
> +			    struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +			    struct cxl_memdev_ps_params *params,
> +			    enum cxl_scrub_param param_type)
> +{
> +	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_memdev *cxlmd;
> +	int ret, i;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		ret = cxl_hold_region_and_dpa();
> +		if (ret)
> +			return ret;
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +			cxlmd = cxled_to_memdev(cxled);
> +			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +			ret = cxl_mem_ps_set_attrs(dev, cxl_ps_ctx, cxl_mbox,
> +						   params, param_type);

Similar locking problem as before it seems.

> +			if (ret)
> +				return ret;

This probably wants to be a "break;", but I would prefer to keep it an
early return with the unlock moved to a scope-based cleanup scheme.

> +		}
> +		cxl_release_region_and_dpa();
> +
> +		return 0;
> +	}
> +	cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
> +
> +	return cxl_mem_ps_set_attrs(dev, cxl_ps_ctx, cxl_mbox,
> +				    params, param_type);
> +}
> +
> +static int cxl_patrol_scrub_get_enabled_bg(struct device *dev, void *drv_data, bool *enabled)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_ps_get_attrs(ctx, &params);
> +	if (ret)
> +		return ret;
> +
> +	*enabled = params.enable;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_set_enabled_bg(struct device *dev, void *drv_data, bool enable)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	struct cxl_memdev_ps_params params = {
> +		.enable = enable,
> +	};
> +
> +	return cxl_ps_set_attrs(dev, ctx, &params, CXL_PS_PARAM_ENABLE);
> +}
> +
> +static int cxl_patrol_scrub_read_min_scrub_cycle(struct device *dev, void *drv_data,
> +						 u32 *min)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_ps_get_attrs(ctx, &params);
> +	if (ret)
> +		return ret;
> +	*min = params.min_scrub_cycle_hrs * CXL_DEV_HOUR_IN_SECS;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_read_max_scrub_cycle(struct device *dev, void *drv_data,
> +						 u32 *max)
> +{
> +	*max = U8_MAX * CXL_DEV_HOUR_IN_SECS; /* Max set by register size */
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_read_scrub_cycle(struct device *dev, void *drv_data,
> +					     u32 *scrub_cycle_secs)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	struct cxl_memdev_ps_params params;
> +	int ret;
> +
> +	ret = cxl_ps_get_attrs(ctx, &params);
> +	if (ret)
> +		return ret;
> +
> +	*scrub_cycle_secs = params.scrub_cycle_hrs * CXL_DEV_HOUR_IN_SECS;
> +
> +	return 0;
> +}
> +
> +static int cxl_patrol_scrub_write_scrub_cycle(struct device *dev, void *drv_data,
> +					      u32 scrub_cycle_secs)
> +{
> +	struct cxl_patrol_scrub_context *ctx = drv_data;
> +	struct cxl_memdev_ps_params params = {
> +		.scrub_cycle_hrs = scrub_cycle_secs / CXL_DEV_HOUR_IN_SECS,
> +	};
> +
> +	return cxl_ps_set_attrs(dev, ctx, &params, CXL_PS_PARAM_SCRUB_CYCLE);
> +}
> +
> +static const struct edac_scrub_ops cxl_ps_scrub_ops = {
> +	.get_enabled_bg = cxl_patrol_scrub_get_enabled_bg,
> +	.set_enabled_bg = cxl_patrol_scrub_set_enabled_bg,
> +	.get_min_cycle = cxl_patrol_scrub_read_min_scrub_cycle,
> +	.get_max_cycle = cxl_patrol_scrub_read_max_scrub_cycle,
> +	.get_cycle_duration = cxl_patrol_scrub_read_scrub_cycle,
> +	.set_cycle_duration = cxl_patrol_scrub_write_scrub_cycle,
> +};
> +
> +static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd,
> +				 struct edac_dev_feature *ras_feature, u8 scrub_inst)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +	struct cxl_feat_entry *feat_entry;
> +
> +	feat_entry = cxl_get_feature_entry(cxlmd->cxlds, &CXL_FEAT_PATROL_SCRUB_UUID);
> +	if (IS_ERR(feat_entry))
> +		return -EOPNOTSUPP;
> +
> +	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
> +		return -EOPNOTSUPP;
> +
> +	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> +	if (!cxl_ps_ctx)
> +		return -ENOMEM;
> +
> +	*cxl_ps_ctx = (struct cxl_patrol_scrub_context) {
> +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> +		.get_version = feat_entry->get_feat_ver,
> +		.set_version = feat_entry->set_feat_ver,
> +		.effects = le16_to_cpu(feat_entry->effects),
> +		.instance = scrub_inst,
> +		.cxlmd = cxlmd,
> +	};
> +
> +	ras_feature->ft_type = RAS_FEAT_SCRUB;
> +	ras_feature->instance = cxl_ps_ctx->instance;
> +	ras_feature->scrub_ops = &cxl_ps_scrub_ops;
> +	ras_feature->ctx = cxl_ps_ctx;
> +
> +	return 0;
> +}
> +
> +static int cxl_region_scrub_init(struct cxl_region *cxlr,
> +				 struct edac_dev_feature *ras_feature, u8 scrub_inst)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_feat_entry *feat_entry = NULL;
> +	struct cxl_memdev *cxlmd;
> +	int i;
> +
> +	/*
> +	 * The cxl_region_rwsem must be held if the code below is used in a context
> +	 * other than when the region is in the probe state, as shown here.
> +	 */
> +	for (i = p->interleave_ways - 1; i >= 0; i--) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +
> +		cxlmd = cxled_to_memdev(cxled);
> +		feat_entry = cxl_get_feature_entry(cxlmd->cxlds, &CXL_FEAT_PATROL_SCRUB_UUID);
> +		if (IS_ERR(feat_entry))
> +			return -EOPNOTSUPP;
> +
> +		if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
> +			return -EOPNOTSUPP;
> +	}
> +	if (!feat_entry)
> +		return -EOPNOTSUPP;
> +
> +	cxl_ps_ctx = devm_kzalloc(&cxlr->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> +	if (!cxl_ps_ctx)
> +		return -ENOMEM;
> +
> +	*cxl_ps_ctx = (struct cxl_patrol_scrub_context) {
> +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> +		.get_version = feat_entry->get_feat_ver,
> +		.set_version = feat_entry->set_feat_ver,
> +		.effects = le16_to_cpu(feat_entry->effects),
> +		.instance = scrub_inst,
> +		.cxlr = cxlr,
> +	};
> +
> +	ras_feature->ft_type = RAS_FEAT_SCRUB;
> +	ras_feature->instance = cxl_ps_ctx->instance;
> +	ras_feature->scrub_ops = &cxl_ps_scrub_ops;
> +	ras_feature->ctx = cxl_ps_ctx;
> +
> +	return 0;
> +}

I didn't check the details of the above for correctness, I am mainly
reviewing this for locking and lifetime rules.

> +
> +int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
> +{
> +	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
> +	char cxl_dev_name[CXL_DEV_NAME_LEN];
> +	int num_ras_features = 0;
> +	u8 scrub_inst = 0;
> +	int rc;
> +
> +	rc = cxl_memdev_scrub_init(cxlmd, &ras_features[num_ras_features],
> +				   scrub_inst);
> +	if (rc < 0 && rc != -EOPNOTSUPP)
> +		return rc;
> +
> +	if (rc != -EOPNOTSUPP)
> +		num_ras_features++;
> +
> +	snprintf(cxl_dev_name, sizeof(cxl_dev_name), "%s_%s",
> +		 "cxl", dev_name(&cxlmd->dev));

Little point in using snprintf if you're not going to check the error.
Perhaps, just do asprintf() with a __free(kfree) and skip the stack
allocation?

