Return-Path: <linux-edac+bounces-3593-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9CFA94106
	for <lists+linux-edac@lfdr.de>; Sat, 19 Apr 2025 04:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946418A4079
	for <lists+linux-edac@lfdr.de>; Sat, 19 Apr 2025 02:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623958F5B;
	Sat, 19 Apr 2025 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGOao6ge"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF533C3C;
	Sat, 19 Apr 2025 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745029937; cv=fail; b=IqTQ2xcvycf1Ek5cYG5lODDYIFOnEg4qlxSreI5IY5X4HNosWeQwPhswrjd3xLNqgnCQTYeVtGnxYDpUddxiDrR8fHRu3XBADPpdkGKLj9vLpBKCCL77Z9WApZaECUw5LEryQHGhW+U4nfbmIOREVOAeE9ameBSZZ9OsI4rEHQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745029937; c=relaxed/simple;
	bh=AA98q98h5w6jjctGKFkJUWtlKWd19onxI8lJ6W6dz6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CvS/cQU+d0MHWJPN3VkOBWYw7HvU2YHi98OhdAhcUUYP50Gf6tD9tgHviecWTGlJ1G+n6iR7B3Z+2cpKrq/wOBDssS4rWrTB46R/GwaykjZOyCEYeGpbdIs4HTN+ozH9q7Bqs7OBugMQ7dZhXY9wnLqA/aDumthXUfj7/GRocow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGOao6ge; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745029936; x=1776565936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AA98q98h5w6jjctGKFkJUWtlKWd19onxI8lJ6W6dz6U=;
  b=IGOao6gefVoHQSuaQ8sXYib8m3IQ1khcUuWVmlHEwnBo9ecGNVbKn+PW
   P8JwsJAPHFe8e3CHHJAkoWM040u9Y+ksd21t4LVnw1ROqonwOynPTpkq/
   kT6xVbjZnfuYb2WlBfWP3hw34x7MIpM2Y46rKfq+HZjqUOelk1umud6hQ
   nhTHv7PYDCknbW/XbZRyIfff7sb63F0fhtp/5mmtrhR6eBaOzQNJRA/Ti
   GGxH/lDucfKGcTSIMMPgm9M00donYhsqQ+1ehXy5uxgsVID2z+W8fu75S
   9Bmgvi56gENuuDIU+uVWVBIQwVGJOiXmuBaLFn1sCBWYKNwOB7lXuZjkm
   Q==;
X-CSE-ConnectionGUID: P+0opPmIT0aPsdHE4oKzpg==
X-CSE-MsgGUID: gnI9a0Q5TYCb5YX3Y/WsmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="56838008"
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="56838008"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 19:32:15 -0700
X-CSE-ConnectionGUID: 0zfJ+Y5lSf6zZm38ZKMPZQ==
X-CSE-MsgGUID: vPk0/TIgQCmc+x5qADZShQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="136082377"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 19:32:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 19:32:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 19:32:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 19:32:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNoVpgeCsEtxI5mZFWU5yfdfH1Q5X1JslxKTfHag9dbWRjGIX7ccqQ3Ex9Xqi/UYILTBF7J6o+dvTZzAAtKPea98agnS7X/klf3ffOXRCxjq2r/ebkvSQchle+G8/RhiAKBr6XesbH1upT4gSrRU4bC5Ka5Nx+ws2B0ZKCfeN9fq7qxTJmT3StZia0r8OID+/4AqgqVkzKB1JpC+gmO8ZfDHAwbiWAKojJm27e3IcXdKE0HMT4PhSu2pbB0vvJxpkR4iK0drZttaWijAH7fLSr+/oCRsB29imHspPj3Y+3MRrqa1Htbc1pRLmAmPLsQn6cDrB2zCtJEV1vHP+kkpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA98q98h5w6jjctGKFkJUWtlKWd19onxI8lJ6W6dz6U=;
 b=eq5KcJhLqCs2cgyPO3I41o9JWv6Upi0I26OarMaASRNtjLsOisuAoFzKqk10gBsmR2dPpx6VoB5Lbvl4WxQQ7t1imknBVQmXxwNYeXPRS9dlrV+PFzBnpjEb/fYzVYztks6rt/XXxfHJAyV7AuKPWE1Qc2Y4sw3YgB7ksBG2o8pAycN8WmmeJh2JNBE3wPDf5LVY4cmlwfwTLTTro915ghr33UZuW6W4vufsFHeIewvCCumiy5G2OJcmFKeekhoLfrPRMswIzNj6i0AKwcXZpWy2uLAH3MYJ9hiaqnPL1QG1r086NCy+ZX0M2fBM2PwoTkKJnzTwF+1CgU4km7EeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Sat, 19 Apr
 2025 02:32:09 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8655.021; Sat, 19 Apr 2025
 02:32:09 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "Xu, Feng F" <feng.f.xu@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>, "Fan,
 Shawn" <shawn.fan@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/7] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Topic: [PATCH 6/7] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Thread-Index: AQHbr6q/0ZTCFWELlku9ccGPSGY3jrOoIYaAgAB/tXCAAOuIAIAAuQ3g
Date: Sat, 19 Apr 2025 02:32:09 +0000
Message-ID: <CY8PR11MB71341040D7F7989091FB16EC89BE2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
 <20250417150724.1170168-7-qiuxu.zhuo@intel.com>
 <aAE-F4nGjuKX-m3e@agluck-desk3>
 <CY8PR11MB71349F22C613DE57758481EE89BF2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <DS7PR11MB60771225065A977E58A8E27EFCBF2@DS7PR11MB6077.namprd11.prod.outlook.com>
In-Reply-To: <DS7PR11MB60771225065A977E58A8E27EFCBF2@DS7PR11MB6077.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DM4PR11MB5309:EE_
x-ms-office365-filtering-correlation-id: 088e3bf4-e979-422f-aa29-08dd7eea6296
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?clB4VWFsYlBhZ3BDSk84aUUvMVU1QWExMCt0cC9nRVBmbGsxVlVDeXZRSUZP?=
 =?utf-8?B?QXdpMWVib2pLYVVYcko0dnlhTUt6WTNyS2lGY0dxbGQ4SDRsUWFWV1p4bUsy?=
 =?utf-8?B?ME9qWUp1ZWlhSlRXOHBoZVFKL3N4RjZNMlN3Y1REcGQwQlFpLzZrVXZhWm8r?=
 =?utf-8?B?UytJUG51RGRIb05HNU5jUytobjM5Wit5eTJYeUhhMjhxZUczWUdCNXkyUmp4?=
 =?utf-8?B?K3paWkkzS08rRDlPQ2VkLzhxSzhqZURHWExMNnZwZDB0eWRWcXhvTkpicXND?=
 =?utf-8?B?eE15cFZMcG1ueXdCQXB4RHlxaHg5WWhsb2Y0d3Z3bDlGdml2YzA3cnhhbGtw?=
 =?utf-8?B?cHZ4ZVlTMHk3RVgwRTBLb096WlhsUk5SSEMrWURjR0RQR0hTUHpnVDhoMVlL?=
 =?utf-8?B?NU5mZllkMXpMNFFFUkZlSVhZWGt2MW5vWWFmY3FaQnVyV3JQTkJiUStxOE5t?=
 =?utf-8?B?NEZOYXpPTnIyczQ4Uzgva2JxRjNwNnBZOHBGdjJYbUF0THhLVlU2aEtlekJt?=
 =?utf-8?B?Y2RIaHUyRnlIT0Rod1VEZGJhUk44VW5jN1pPdks4dm1DZU1UY1FRUTRxejBE?=
 =?utf-8?B?Ri84dm5ZVWVDbDNBVVVyTmVjQXliMkVZdzFkSkV4QTBKellIQkpqZk5SVUVs?=
 =?utf-8?B?TmZkakIxL2tHK2FkQzh0bUVpMjRQSHcyK1BjVEF6L3V2N0F2UU9YanJxWFdK?=
 =?utf-8?B?UXA5S1lmbzNHKzZ4QlBFY0xNdVVFVit0SmZBSEJHeDM0QkFSeEJYcStuc1NZ?=
 =?utf-8?B?dmw1alo1RU5HcytDVHZ3aHA3WFpmY0VpTVllMGVXaXpJeGtpWWZ6MSs4ZUJH?=
 =?utf-8?B?RTZuVEFheWRVMkxvYTJnZzZ1OWlTNHhQZjBuL3RvMjNaK3E0a3ZubE5zZ1Iw?=
 =?utf-8?B?TGJIUWhOMjE0bExzYldtVzU3bzlhSDEyaXlERlNlZEo1OWR4RlJFUHpVdGha?=
 =?utf-8?B?bXhqNUNzMzlOQzZSbzNjYWY1cHMxdTl1Q3QxKzhUbFZGL1FieVlvaENwNWlW?=
 =?utf-8?B?N2VNL3doWkJVVVlsMzNVUEJVcFJtSHNVdDNoSTNpNm5ieXNSeE91M2tmVzZn?=
 =?utf-8?B?b1diWmkyRFJjOXFnczIrUEFPR2t3M1ZGaVRGRFJpbDNTOHZVNzZCU3pKY2NE?=
 =?utf-8?B?Mm53NUVXTE1TWlNLb1d5bmtQdW1rMExEUGFVYjhIdzJTeVdYcEcrNklGeTVq?=
 =?utf-8?B?WFpnZzR1eGFMUFRkb2JnM0FReEM3NWFtWHZVYndLMlJrTkFaWnYyV1pMNTQ4?=
 =?utf-8?B?VGNIVnVFZnVqQ1FWYlA0ZTZBU1hkb1BhcjJkOWJndkpwaHF0Kzd5V21vb21Y?=
 =?utf-8?B?a3lkd3VvUWREK0pWbXBEQW5ROG1LUitrZ1ZaSVdYeVhtOEw0WUs5TGphOWNw?=
 =?utf-8?B?d2ZpZFNibzk0bU80N1NnZ29SdlI2ellUbU1oME1qU0hWMWE5VlVLcTdEcHk1?=
 =?utf-8?B?NWFSWnN5UW5lK3NZdzhpNmVoaUpSd0FZU3JNMkEzWlgvelNjMG5nSHRKbkdR?=
 =?utf-8?B?UE9BWi9LeXh3MHZpZS94Y3FaVm1PdlhaMnNYbmkxaDhkTnJFZzF3Y0ZSTlZx?=
 =?utf-8?B?MkRRZXpVV2tGT0lkYk1LRzdCeTlnR3lZWnJWVXpRUUkwdzZSRDBHVUpGZk5L?=
 =?utf-8?B?QjhmZ2t5cU55QmVOVnhTTFk4VjFCaFVCdGNvd2VaMUF4SVJqaVZGRy9sNUJP?=
 =?utf-8?B?Zm9mSzNWUEdFR1JaZmtUWk9oZTZEdFdCVVRtenR6RGYxVVBFZGhZcm1mZXMz?=
 =?utf-8?B?TDVtU1lsV2xxcCtpTG1JYW56RmZDZExyRXNGQlQ5NUZDeXluNHhqSStpR05z?=
 =?utf-8?B?UjN5M0I5MUs5V0VQMzNVKzJVNzFyM3d4c2JRMERGMGRWQVVRWGlid3VDTXov?=
 =?utf-8?B?OVJ5YUd2d3I1ZlcyWXh3OG9xVEJCczRMd1ZNZXpiNFpxbGUybW9YOVp4T2po?=
 =?utf-8?B?VDdrNFJFWFZGYlUyUjhYdXNUdmUvbkRJS2c3bmlHTURmZE1OV1FHbzZqTzJ5?=
 =?utf-8?Q?9q1kCQmRGF6R2KNaOXYSsaUqWlMeNo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTRwVGY2cUkvS3RuYzFkeWdNdjRQdGpBME9jNkZmRzVzdjFSaHYvaFRyYW9C?=
 =?utf-8?B?QmMySjhON1BmczdUZnE4cDVMbWJqbzhLcDhhWXBuaHR6ZDBuOVpZaG94dXpS?=
 =?utf-8?B?bFdMKzVoVVo0L1A5aHFFVEFHM0EyZkFqNmZqR3lkT1A5TzM0U2dJN3VuK2ZI?=
 =?utf-8?B?VDNDb0pPZnllVENLSC9Uc2hOOWMrK0wxa0oyVU84Z0F6RG1zMm9vMS91OXc5?=
 =?utf-8?B?RHJNcm40TjUrbjVhR3lwb2w1TURjZ2RHUlh6S3E4MkdEcDI4S3loZm5FeVhP?=
 =?utf-8?B?bFhOTjZSTlUyckdQNkxOanBCbm83NUR5cmV2WGN5b0lJSXp4Nm1kR04rMVo5?=
 =?utf-8?B?Qm1DVkllQmJTREg0MTV2YnlPd3pTeVkwQ0Zib3J5L2Y4K3dQUGx1VnpkZEp1?=
 =?utf-8?B?OXo5bVlsSlRqZE1SRTBoUVZleHJLVzEva05wem1vQnQ5VEJoSHpmTzRaaGJ0?=
 =?utf-8?B?aUxvazFiekJ0eUk3eXlSd1h0TjBLQ1oybkptWFprQWhDcGUxRmpzOUhaM2hC?=
 =?utf-8?B?Y09TdVhjd2RMK05CSGIvMjRTbWFQVTVGbm1NMmYzRktIV204Umx2L0diSEZh?=
 =?utf-8?B?YWY1R1VxZFh1WkhCcU8rK3JBVEJtVm5nT3B6TVMvQTFTMVN0cU1MR0dOT3BY?=
 =?utf-8?B?Qmp5Z0tNZk9Oa3QxQk1DeXlmaitSL3grL29nNDNrTDdvT2o2dm4rYVpEZ3dE?=
 =?utf-8?B?M25jYW1MMXZxZkQwNFFrT1QrT3I0QjFVZmcvbkZXalB3WFlVTFA2bWRuY0Qx?=
 =?utf-8?B?UEpLL3d3NUREeDc0Qnd0M1Via0ZZSjI2bzJqZXJPVU5tNlFGVVlRSWtNRnJk?=
 =?utf-8?B?eThnWlpPWmI2TGQ0WnVrWGovNWkvMXlGMFhHcFpmL3lvbzFnN2RMNDE4Z1Fp?=
 =?utf-8?B?R0ZtYTdSYVpTaVJSQ3ZzK3dvaCtmRWJlSTRDY3dmb2R0NUFMb0FCNHZWYUtX?=
 =?utf-8?B?aC9IWkN0Y0FieUxnSC9GNVk1RDlETXhieERWeHEwMER0c3h2OVhmOUYrNHk0?=
 =?utf-8?B?Ulc4TlhXTCs0aEJGeTYrcCs4Z1EwUm1vWkNZb1JvWHptVnZTV2U2bjZ0S0RJ?=
 =?utf-8?B?RjU3SzZjRmtWRzBJdWxocnFWMVd2RXllNVR0Z3hjSC9rQ05OUm5ZVkZKZjhL?=
 =?utf-8?B?eFBUeWczQU51U2IyVVZqK2dGbXB3c0dMNWZHMC8yU3U2Z1dBUnRLRHV0Qmt2?=
 =?utf-8?B?WEFkRkVXbXpLZnFGUmRLOXd3RGFrLzI3eGRKOU9RVFdoR2JDOVZhdFl0QVRq?=
 =?utf-8?B?NVFkMmtDTW85RFUrUkk3a1BYNjE2dkRqL0hXbVZQcUU4UkFxSkFVZHNNMEhB?=
 =?utf-8?B?MUNta1VlK0pqZzhlS293TFVLSUxiWG9aYTNrWmlEN0s5bXF6Q3o3UTlkbUhv?=
 =?utf-8?B?cTlZMWk2a203Rkhab2xOWm5TRmo0Snh4cGN5WVUvcElHdkNCRFduKzBmQ2lr?=
 =?utf-8?B?UlRZdnpKRXYwNWdldWhtTjFDRHFZMWF2SlFmNnBBK0pVUERFRjJYZjhlRlRN?=
 =?utf-8?B?ZUJBUDJZNjYyRWsreEJMdUZkNHpzRU9xYTBtM0tZTUJZU29sdlJXZUhoWGx4?=
 =?utf-8?B?a3E3SXpvekVtZzlUVDBWaHF3VGN2K1ZVdzlaaENvU0RvUk42NU9XbGFVSXFY?=
 =?utf-8?B?MnZhZUN3cDQ5VWtDa1JIdWZrQll4QWJTY0VuMzgxeWl0TWV0WkpybGhCTTh4?=
 =?utf-8?B?L2JmU3QvV2lNUFU0aXpROVljZUVYdmI4dkMzUkVkbDlNN2c1UE5ZaU9ENS9m?=
 =?utf-8?B?NkN6Y0lXV1BwK1VqeUFBRVE4MWFjSGM5WGdUVnpISE5abFdmZHh6QlAwVnVv?=
 =?utf-8?B?a2lkQjhuUGo1VXRsejY0UEJqNGo2N3dRbVZrMmkzaTg2TUtNbWxCb29BNXhr?=
 =?utf-8?B?T1RORmFCMGRGZ25RdnZBcFNMcDNqNEdxNWdkRDhic056YnBMdGE1VGlFbkF4?=
 =?utf-8?B?c0ttOG95N0NwRWJ0cm04YU5DSnpSQk01Y0NKRzl3bUZGUTBLeEw2VnlabEJj?=
 =?utf-8?B?SWtEYnIxa01zRTNMa29EL21iaTd5cmREbUZNei9URzZ6enlJOGc0WE9WVDNa?=
 =?utf-8?B?U0FXYnBDUTh6TUtSTVM5NEpnUmdiYjFaV1JObmJBSGZ1ZTRUZFVkalpvWXRY?=
 =?utf-8?Q?BII5w4fYyRbCAeOX38xQvadmM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088e3bf4-e979-422f-aa29-08dd7eea6296
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2025 02:32:09.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VO36nW+moxAo8RWNq9Qy8gNb5ML7D6CVr5yciOvoLL/SkMUAeUsUKgC16ouani80vX0yJk7J2RxmOeQ43UuYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com

PiBGcm9tOiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBbLi4uXQ0KPiA+IERv
IHlvdSBzdWdnZXN0IG5vdCB1c2luZyB0aGUgImNlY250X3dpZHRocyIgZmllbGQgZm9yIG5vdyAo
c2luY2UgaXQNCj4gPiBjdXJyZW50bHkgb25seSBoYXMgdGhlIHZhbHVlIDQgYW5kIHRoZSBjb2Rl
IGFwcGVhcnMgc29tZXdoYXQNCj4gPiByZWR1bmRhbnQpIHVudGlsIHdlIGFkZCB0aGUgRURBQyBz
dXBwb3J0IGZvciBEaWFtb25kIFJhcGlkcyBpbiB0aGUNCj4gZnV0dXJlPyBPciB3ZSBjYW4ga2Vl
cCB0aGUgImNlY250X3dpZHRocyIgZmllbGQ/DQo+IA0KPiBUaGUgZ2VuZXJhbCBwcm9jZXNzIGlz
IHRvIGF2b2lkIGFkZGluZyBjb2RlL2luZnJhc3RydWN0dXJlIGZvciBmdXR1cmUgdXNlIChhcw0K
PiBzb21ldGltZXMgdGhhdCBmdXR1cmUgbmV2ZXIgY29tZXMpLiBCdXQgSSBoYXZlIGhpZ2ggaG9w
ZXMgdGhhdCBEaWFtb25kDQo+IFJhcGlkcyB3aWxsIGFwcGVhciBvbiB0aW1lLiBTbyBJJ2xsIGxl
YXZlIHRoZSBjZWNudF93aWR0aHMgY29kZSBpbiBwbGFjZS4gSXQncw0KPiBub3QgbXVjaCBjb2Rl
Lg0KPiANCg0KT0ssIGdvdCBpdC4gVGhhbmtzIGZvciByZW1pbmRpbmcgbWUgb2bCoHRoZSBwcm9j
ZXNzLg0KDQotUWl1eHUNCg==

