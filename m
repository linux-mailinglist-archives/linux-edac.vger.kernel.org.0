Return-Path: <linux-edac+bounces-2026-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F293F99BFB6
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 08:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB7A282FAC
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 06:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A391B13CFA3;
	Mon, 14 Oct 2024 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVIpxm+q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C0762F7;
	Mon, 14 Oct 2024 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885883; cv=fail; b=dYDU77xAXR+kT2TygMl+qm5RlAYFhMdwYlaLzRbuYkdoYgHX7GNrclUZhrA6ihoI24Dg39Megk4IXAysvZjSFONbq6Nou+N/7Kzny0q/PDkWW4e8HOvwgoDhMZqzq+DTjB7oA/+oQbD33HjEEIibGOqdhNy0HoBMaWlqOPELhw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885883; c=relaxed/simple;
	bh=k5zvDmsWCKztiyZ7kx12jfclzOq0MkISTrsDBBFna/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPEKM4HScXDMCz9y0CmzmW3kQTaFLXIYdHq7ploZOxbUFg1agYJ2ZkPTRftulnuwpH8NwU+Yb+/sfWIThlTgqtStWvbAaBUTyt2NiuYTwn9xJpbDcbR+2VpHK6WaiV1KyZ7+Tz9iO3oN5+6wKl+ctMJOE/LjbPQnbTJMjCsJ7ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVIpxm+q; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728885882; x=1760421882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k5zvDmsWCKztiyZ7kx12jfclzOq0MkISTrsDBBFna/w=;
  b=NVIpxm+qSfunpeyUUZxLzS0vxzW0Vt8PTk0gVjUZyr/A6t7jCNc0yNCh
   Vr+AjmkoKlAXbpWAIOl/DAEK824VD+A2V6zC7/En8CwgDREGq6HCcuWSJ
   /P7NJdXJcbQCJbzxkcx3CM2SLKangIWL3CNLDZ5bNem5s37zWRwxPXaX0
   /EFQ9hgFTDnSOMHpgSRZuuia+Wi3MoyQCD09xHHIN/6JomiqejwlJX/aD
   vs4K+Vur8zruqGgEroHSfXOF8kAznvOhNj2GlwgT+1m31ic8guxPpJVzT
   pNUDlWkWX2N1l6KUpezM0vaTPP0IAY6xmN2AUOoOWUehzusMRTbLF4qR1
   g==;
X-CSE-ConnectionGUID: cFmeRKkGShm9pNvV05sq4g==
X-CSE-MsgGUID: TCMUmvvNTKukwpO9YwbxwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28404716"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="28404716"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 23:04:39 -0700
X-CSE-ConnectionGUID: z1YPZleSTi27nIqexyEuIQ==
X-CSE-MsgGUID: NZaOChAiTSOgoq8mk3OkFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82264961"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 23:04:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 23:04:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 23:04:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 23:04:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 23:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+co4e6xp1PH8l+74hDtrgZR5A7ySJmB1R8wnqHfgErhVqPVkJnaY6FPs8k5DekT8AH8/+W3za+3lU42u7NRzdNnY9B/grr+Z7zXGUBav0rdXPFmlFNcGtPVYRt9odPq6L6LVulQ7SjQPxfcu5VGuJaVSvTSf0Gs72IqAhkfInjqb/iQWBXgJ85IhlrMQfky3zl4WEkHrmC3szXWaOlvQIBIJ1JgqfaNmTdLs3Wc45HK3LYVUUOqzJI1v7ZFa8K8wBvTD5eVIVDjV+TjrO81y2Bdvnh+POmPsx7wx9vAjSwrdLk5LwrKhHeEggr0/QlcR2Vcld2HY6VgH8jnx9yngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy+hqVBeYWB65Cv3svZKe1VCUGIpooeRVggDmnE84gc=;
 b=E8RT6Z2Iao8Bxe6ewt7o6YF4sU20pGdJQRJxiOCLFR173cD/mq9MkPijqSVZWOsVqEa/fPaP488Xca8irvZ/zY33HDlRTDBTlbnC4BpsA32Cn3HYbhzrwAxPqmF3PabEN9q337MapTLhnfI8Ro8BMUGCwSQ081uzRlzWJz0/shRrnCAsGZZpwx8F5rHCG52kXu+hSfhPqC+4Z/LI3mYvInkcKoaQNqBQyBLVovkNkKhjhmHwJ37QjU4ciXSwx4FwClSGpUbrxJuduyEPARLrSalnTQiDSzJPezmqNpZ//eBjk/dS3u0DX2QRi/t9fjr5Lm7OBvdPe1RGfJLozLHjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 06:04:34 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:04:34 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"john.allen@amd.com" <john.allen@amd.com>, "avadnaik@amd.com"
	<avadnaik@amd.com>
Subject: RE: [PATCH v5 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Topic: [PATCH v5 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Index: AQHbFC4gq0D4a7cjHUu601KFGBrzrLKFynTg
Date: Mon, 14 Oct 2024 06:04:34 +0000
Message-ID: <CY8PR11MB71346A3B771899EC335E444489442@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
 <20241001181617.604573-2-avadhut.naik@amd.com>
In-Reply-To: <20241001181617.604573-2-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB6450:EE_
x-ms-office365-filtering-correlation-id: e36af3b4-17dc-45b4-a95e-08dcec1613e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?D6wv+aYp5SDUA6MZ3/Lsqroqo9VCJbLRdXWgGlF+cAnUhBhBQFLbkHkVpRQ7?=
 =?us-ascii?Q?bxAVmpTtrVx9P9gsRBtZue1VQBCQSd/LgOUgG03fCSnveiHxemGMc50fkSPb?=
 =?us-ascii?Q?jAvMdbpWH9ZYvUgLMjABt/RjR+142cttkAcqNxXD9yL0fN06gcdP4zlRj0kn?=
 =?us-ascii?Q?VTk3Lab+8P6/gNQ8AyWulNTCaB6wSr7zoZlBl/HBygwJcga+DYg3E+Q5DXod?=
 =?us-ascii?Q?fDg26bFZdRnnCs/JXO3hhcj/E09Hsvjgzjn6QNvPkZvCzg7znFUw4aoD8Kcu?=
 =?us-ascii?Q?8YfBSsrzVz+CKt0vlVaD6W9MiYbuhsW+o/HfA5kq3szCssOorZqf/124rOHb?=
 =?us-ascii?Q?tLpKPcjojQXWsBpQiURCYsZHgEvmAoaE2qEr+/wOK1N9nCboGE9RPwVFIND2?=
 =?us-ascii?Q?FBS7D5iXn0kjpD85iG71vwsvipmnP9Y3R2dxFX5wi4OxNh63AIPU4z+L0tJY?=
 =?us-ascii?Q?ypB/YGpzsNMXhCBSB1iJiM+yotS9uP7UqF+/vTLh7t2Uv7PEYImwyStru0dk?=
 =?us-ascii?Q?eiwifIVN89QmjZ+Osn/Y55E9ERwzmCCLOeZiLi4blFpgUaGSshI9EmPYSKve?=
 =?us-ascii?Q?/VdoJY/eVtaw+w02dRxYplpA80NPinfCXOJdsQufssc8JJnw3e2IsiVHKPTH?=
 =?us-ascii?Q?ju1kDFmgKx2J+aPJLtLec/q2w5iF+rxrha7/mTL5IyBCCRePka2ai3fmaEEn?=
 =?us-ascii?Q?d8FgZT53skUB+HDw26FYW7XGJMwxfmIQrOB3lp7X9YH5Mvp4tJBw49sUGQl1?=
 =?us-ascii?Q?ZjbjX+fnPnI5ZdbblGT/DLjjYKKGBm5SsKuWDsSWGHSa++ah4Ex2SMLNF1FL?=
 =?us-ascii?Q?IynKkzMtYdoZVkhMGfCDlGhqYfSgkCzjALaoj24cnZ617700kcvHAsfRUPNn?=
 =?us-ascii?Q?n/9TaW2tq1uKPEoEx85Hlg7wKAV2R6uIv/R3vH1Gkibvn/1EcIjstqaNS7Id?=
 =?us-ascii?Q?deqARUXw/hxlZCjBOoIFmBrpvGUqGi49i5C60tAkD2wyHfm1okg1uv52zCJI?=
 =?us-ascii?Q?o00snpy7QC5sQ9uSirg+2PdJkJgaetfnAeaSYkyNB3Rf/oCdWfvHF1VK5BWU?=
 =?us-ascii?Q?X7aZgmk5c5IChM0BVFhqCdkB/SVlm3bC6F7E+LLhBnMRJIT84upJm7OE8scu?=
 =?us-ascii?Q?UFTLo74ffe9QkackE6/7z5hbje4Tyz9xPnQijUDJi3FMc0VhQS0xw0StnFcG?=
 =?us-ascii?Q?l7ShhwHVCe7j/haPqq+LbN/oVowC2BTwEfkR1JpNhRxG43oEVv3wBk30IzfQ?=
 =?us-ascii?Q?98iZ+NEXRlL1a6GhRAO5u6HznTJpUnNoDIZj79C3KOYcVCL/lPj5dpAp7oZ8?=
 =?us-ascii?Q?Wt9Y0BPRVLTZV+1+ehyWrwiiyj8BnqBJE4KIHdY+rGUO+A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gd24dpc/BLAFTbMGBXAsfgdLPOuAGyMUuBmb//ka284Cz4FBszRLnavC5dzD?=
 =?us-ascii?Q?tUsn+ywry+k4K4qpUC+5S1zkT0GliytkUF3s5mAvhxH29u8l4niq4BCdTysc?=
 =?us-ascii?Q?QXrjAPo1CQjld8bX1udp7ZKVaGxy6OtsgeVgyxiFQmrtZ8KWhEl2bVdWemcg?=
 =?us-ascii?Q?pbaj+RKsUldBPzfZjlnjF4MA+ja088OCPI6udJaIs0jRiEdUDU4CMOq1JRIb?=
 =?us-ascii?Q?nTu+rrS1/+WQLTEu3YOw4ocxOA5S1ioDVXSVtet6zpNqhl5SlT5vRVS0Srh3?=
 =?us-ascii?Q?Ew8kvdKK5WacvVXVLbxV5vB3SkCHMn7rcfZVt2oNaj/e2OBdSnaiYrxv3cIo?=
 =?us-ascii?Q?N+ncHsEXq6kJExdMGB+1kZ923lBfn++oKAritNGIldNB9wpFePTMeuKoZ8xK?=
 =?us-ascii?Q?xF7XVFzT7vOYNchicX+cKmT5u/OZMMVSymwStb+sOz87IIzp9r59RKOFClLE?=
 =?us-ascii?Q?/0nzaqftuQMf07qAt3HXYn3q14fFw75nrW7F7OpR1ASwzSWefQ320c5Kq8oV?=
 =?us-ascii?Q?sZfIHtlSAUIPAeuY4BUdEXh35GaaUYhvmDKlLEKCElBGoMZE8tWs3BGrSkjP?=
 =?us-ascii?Q?fbWuVve5ZFOOxReZojw7kARMhAXcPNFKexLNqTpZ2dL4AwGgEQnr1/Lte/R1?=
 =?us-ascii?Q?dAC6ZLiW1i4ERhQbj4puRBkjTcOda8mf1laLgRDTnRYAkLYu42EmkbJx0Ta5?=
 =?us-ascii?Q?hMRUydzianiwVwlaCyd4/rrflZtYUb8yiZ/7nPYRbHMAt/3JDVoQuLrPacbw?=
 =?us-ascii?Q?eqiOLA3atqHmyYW/Ltja6OuzBiPNXLSfMbKrqlG8t8yTY4sXzv/7D0sBr6mg?=
 =?us-ascii?Q?XLZoCuU3NUp8r5tDJ5Qcx67EV2xSMqjaZVKV845Lj3eJxOimgqmGHcCXjtIg?=
 =?us-ascii?Q?QAT8cjSIdupSCt6L1iQMiOPUDQLY59fyrCfRLxUfgXh8oXbC1ON3MW7c3jvn?=
 =?us-ascii?Q?oVrhm4FOa4EVBVpTwFlh2optBGIkMCFjcuZK+2DyZH2X4rNZ6bq6E/Hdrg0P?=
 =?us-ascii?Q?+NuERn90IOLizmguEI2LJucGnwl2jG1ucr/2LuMWm5P+k7vKmi0MsIyOAd33?=
 =?us-ascii?Q?7Ek1PkG1OGHzB1CnjUhvEzwPN+DKlQpIpruoJSsTOklMNoAuD1ZxTagZ3TeM?=
 =?us-ascii?Q?ti369CgBCyUXNREpM1oLL3Y/4IKS5u6Fj4zORh97/Xwt5Dtuzu67SMuyTPLg?=
 =?us-ascii?Q?GikfHXoDNVUmTtFDvrgr6dKMbDzc/Hwf0FKD5/I9Auk1Oz0ScbBbqqOMRnr8?=
 =?us-ascii?Q?6Ea82l0VM8pIt904ziYXWQDdLl8p0MvV6qyhiXA4IIm5wXNOIEUxAsW0bJeK?=
 =?us-ascii?Q?Cd1PtoApWmk4PCobX2zGXJ9V/TBePV4FwIqc3uyFqREcW+ImpbFA9QzKyFv/?=
 =?us-ascii?Q?9Pq6fSGC3S9vsiNML7VTDbqLq/E5svZ2SePXMwVc3IEVJlMJLwvWZ+f7ai/p?=
 =?us-ascii?Q?4RksQFvOBoIeBiXK7pb52NoywNav0y65D3mfBOuYLuIVd02Mk2g7WW14Zx67?=
 =?us-ascii?Q?LwgHmJavTb8RWtM2TIdMgsHWbM+2vnbhfJCwOfx3h4HBpVo5cNV1BhTKGFNG?=
 =?us-ascii?Q?1roBhkF4l43wgZvB+Cw2xVpD0xtqkavQQqIIchHg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36af3b4-17dc-45b4-a95e-08dcec1613e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:04:34.6492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxVSHL1o3EiVfr57vfDGhGMIqRHdKeldxK+4vPrjkt0EtUrEZGHmVq/TsdsZ+7clPIg6JUFJBxr5Ez1DsP8ohA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com

> From: Avadhut Naik <avadhut.naik@amd.com>
> [...]
> Subject: [PATCH v5 1/5] x86/mce: Add wrapper for struct mce to export ven=
dor
> [...]
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -187,6 +187,14 @@ enum mce_notifier_prios {
>  	MCE_PRIO_HIGHEST =3D MCE_PRIO_CEC
>  };
>=20
> +/**
> + * struct mce_hw_err - Hardware Error Record.
> + * @m:		Machine Check record.
> + */
> +struct mce_hw_err {
> +	struct mce m;
> +};
> +

Just some thoughts:=20

I noticed that many places only care about the 'mce' structure instead of t=
he new 'mce_hw_err',=20
such as the EDAC drivers in the notifier chains.=20

Could we still pass these users with the 'mce' structure instead of 'mce_hw=
_err',=20
since they only care about 'mce'?  However, they still have the opportunity=
 to
get 'mce_hw_err' from 'mce' on demand with the following macro. [1]

   #define  to_mce_hw_err(mce) container_of(mce, struct mce_hw_err, m)=20

So, for those codes that need 'mce_hw_err', they can retrieve it from 'mce'
on demand by:

    struct mce_hw_err *err =3D to_mce_hw_err(mce);=20

For those codes that don't need 'mce_hw_err', there are=20
no changes to them. I.e., they do not need to perform the extra operations=
=20
like below over and over:

   struct mce *mce =3D &err->m;

> [...]

>  static int mce_early_notifier(struct notifier_block *nb, unsigned long v=
al,
>  			      void *data)
>  {
> -	struct mce *m =3D (struct mce *)data;
> +	struct mce_hw_err *err =3D (struct mce_hw_err *)data;

If using [1], then it can be:
 =20
    struct mce_hw_err *err =3D to_mce_hw_err(data);

> -	if (!m)
> +	if (!err)
>  		return NOTIFY_DONE;
>=20
>  	/* Emit the trace record: */
> -	trace_mce_record(m);
> +	trace_mce_record(err);
>=20
>  	set_bit(0, &mce_need_notify);
>=20
> @@ -597,7 +606,8 @@ static struct notifier_block early_nb =3D {  static i=
nt
> uc_decode_notifier(struct notifier_block *nb, unsigned long val,
>  			      void *data)
>  {
> -	struct mce *mce =3D (struct mce *)data;
> +	struct mce_hw_err *err =3D (struct mce_hw_err *)data;
> +	struct mce *mce =3D &err->m;

If using [1], then there is no need for these changes.

> [...]
> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> index af44fd5dbd7c..d991ef370efd 100644
> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> @@ -36,7 +36,7 @@ static DECLARE_WAIT_QUEUE_HEAD(mce_chrdev_wait);
>  static int dev_mce_log(struct notifier_block *nb, unsigned long val,
>  				void *data)
>  {
> -	struct mce *mce =3D (struct mce *)data;
> +	struct mce *mce =3D &((struct mce_hw_err *)data)->m;
>  	unsigned int entry;
>=20
>  	if (mce->kflags & MCE_HANDLED_CEC)

If using [1], then there is no need for these changes.

> [...]
> @@ -83,8 +83,8 @@ void mce_gen_pool_process(struct work_struct
> *__unused)
>=20
>  	head =3D llist_reverse_order(head);
>  	llist_for_each_entry_safe(node, tmp, head, llnode) {
> -		mce =3D &node->mce;
> -		blocking_notifier_call_chain(&x86_mce_decoder_chain, 0,
> mce);
> +		err =3D &node->err;
> +		blocking_notifier_call_chain(&x86_mce_decoder_chain, 0,
> err);

If using [1], then continue to pass 'mce' as before:

     mce =3D &node->err.m;
     blocking_notifier_call_chain(&x86_mce_decoder_chain, 0, mce);

> [...]
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c inde=
x
> ca87a0939135..4864191918db 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -134,7 +134,7 @@ static int print_extlog_rcd(const char *pfx,  static =
int
> extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> -	struct mce *mce =3D (struct mce *)data;
> +	struct mce *mce =3D &((struct mce_hw_err *)data)->m;
>  	int	bank =3D mce->bank;
>  	int	cpu =3D mce->extcpu;
>  	struct acpi_hest_generic_status *estatus, *tmp; diff --git

If using [1], then there is no need for these changes.

> a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c index
> d48a388b796e..b917988db794 100644
> --- a/drivers/acpi/nfit/mce.c
> +++ b/drivers/acpi/nfit/mce.c
> @@ -13,7 +13,7 @@
>  static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> -	struct mce *mce =3D (struct mce *)data;
> +	struct mce *mce =3D &((struct mce_hw_err *)data)->m;
>  	struct acpi_nfit_desc *acpi_desc;
>  	struct nfit_spa *nfit_spa;
>=20

If using [1], then there is no need for these changes.

> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c inde=
x
> 91e0a88ef904..d1e47cba0ff2 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -1810,7 +1810,7 @@ static void i7core_check_error(struct mem_ctl_info
> *mci, struct mce *m)  static int i7core_mce_check_error(struct notifier_b=
lock
> *nb, unsigned long val,
>  				  void *data)
>  {
> -	struct mce *mce =3D (struct mce *)data;
> +	struct mce *mce =3D &((struct mce_hw_err *)data)->m;
>  	struct i7core_dev *i7_dev;
>  	struct mem_ctl_info *mci;
>=20

If using [1], then there is no need for these changes.

> diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c index
> 189a2fc29e74..091126a42884 100644
> --- a/drivers/edac/igen6_edac.c
> +++ b/drivers/edac/igen6_edac.c
> @@ -919,7 +919,7 @@ static int ecclog_nmi_handler(unsigned int cmd, struc=
t
> pt_regs *regs)  static int ecclog_mce_handler(struct notifier_block *nb,
> unsigned long val,
>  			      void *data)
>  {
> -	struct mce *mce =3D (struct mce *)data;
> +	struct mce *mce =3D &((struct mce_hw_err *)data)->m;
>  	char *type;
>=20
>  	if (mce->kflags & MCE_HANDLED_CEC)

If using [1], then there is no need for these changes.

> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c index
> 8130c3dc64da..c5fae99de781 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -792,7 +792,7 @@ static const char *decode_error_status(struct mce *m)
> static int  amd_decode_mce(struct notifier_block *nb, unsigned long val, =
void
> *data)  {
> -	struct mce *m =3D (struct mce *)data;
> +	struct mce *m =3D &((struct mce_hw_err *)data)->m;
>  	unsigned int fam =3D x86_family(m->cpuid);
>  	int ecc;
>=20

If using [1], then there is no need for these changes.

> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c index
> f93f2f2b1cf2..a3008f6eb2b1 100644
> --- a/drivers/edac/pnd2_edac.c
> +++ b/drivers/edac/pnd2_edac.c
> @@ -1366,7 +1366,7 @@ static void pnd2_unregister_mci(struct mem_ctl_info
> *mci)
>   */
>  static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long=
 val,
> void *data)  {
> -	struct mce *mce =3D (struct mce *)data;
> +	struct mce *mce =3D &((struct mce_hw_err *)data)->m;
>  	struct mem_ctl_info *mci;
>  	struct dram_addr daddr;
>  	char *type;

If using [1], then there is no need for these changes.

> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c index
> d5f12219598a..f771c36540cf 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -3256,7 +3256,7 @@ static void sbridge_mce_output_error(struct
> mem_ctl_info *mci,  static int sbridge_mce_check_error(struct notifier_bl=
ock
> *nb, unsigned long val,
>  				   void *data)
>  {
> -	struct mce *mce =3D (struct mce *)data;
> +	struct mce *mce =3D &((struct mce_hw_err *)data)->m;
>  	struct mem_ctl_info *mci;
>  	char *type;
>=20

If using [1], then there is no need for these changes.

> diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c index
> 85713646957b..5fa3a9038a77 100644
> --- a/drivers/edac/skx_common.c
> +++ b/drivers/edac/skx_common.c
> @@ -644,7 +644,7 @@ static bool skx_error_in_mem(const struct mce *m)  in=
t
> skx_mce_check_error(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> -	struct mce *mce =3D (struct mce *)data;
> +	struct mce *mce =3D &((struct mce_hw_err *)data)->m;
>  	struct decoded_addr res;
>  	struct mem_ctl_info *mci;
>  	char *type;

If using [1], then there is no need for these changes.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1a1395c5fff1..88648a89fbdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4160,7 +4160,7 @@ static struct amdgpu_device *find_adev(uint32_t
> node_id)  static int amdgpu_bad_page_notifier(struct notifier_block *nb,
>  				    unsigned long val, void *data)
>  {
> -	struct mce *m =3D (struct mce *)data;
> +	struct mce *m =3D &((struct mce_hw_err *)data)->m;
>  	struct amdgpu_device *adev =3D NULL;
>  	uint32_t gpu_id =3D 0;
>  	uint32_t umc_inst =3D 0, ch_inst =3D 0;

If using [1], then there is no need for these changes.

> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c index
> 90de737fbc90..78dd4b192992 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -400,7 +400,7 @@ static void retire_dram_row(u64 addr, u64 id, u32 cpu=
)
>=20
>  static int fru_handle_mem_poison(struct notifier_block *nb, unsigned lon=
g
> val, void *data)  {
> -	struct mce *m =3D (struct mce *)data;
> +	struct mce *m =3D &((struct mce_hw_err *)data)->m;
>  	struct fru_rec *rec;
>=20
>  	if (!mce_is_memory_error(m))

If using [1], then there is no need for these changes.

> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c index
> e440b15fbabc..be785746f587 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -534,7 +534,7 @@ static int __init create_debugfs_nodes(void)  static =
int
> cec_notifier(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> -	struct mce *m =3D (struct mce *)data;
> +	struct mce *m =3D &((struct mce_hw_err *)data)->m;
>=20
>  	if (!m)
>  		return NOTIFY_DONE;

If using [1], then there is no need for these changes.

> [...]

