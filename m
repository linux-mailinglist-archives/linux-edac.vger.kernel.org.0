Return-Path: <linux-edac+bounces-5391-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD2CC3B5CC
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 14:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 315D1350987
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C53347BC9;
	Thu,  6 Nov 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIL15r52"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDD346E78;
	Thu,  6 Nov 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436334; cv=fail; b=lTEGa/8rRBpLQYEgqXkrb3/QyAmfhtr1uAUh9gOGZX6b1boYoG0lgy/TIpkE7LDneQB1d7F0jMMAkSDa5CNQcqCJnef1bQELyU9O6QQZGS6mN5sOVLyFTAKUVNEwB42YrXxoX6rGBPAUWWPgx7l997Tw8Xo5ynsEtJ0/pLjYO9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436334; c=relaxed/simple;
	bh=EHpqxprjgPTrEK8uxt4T6opZkPg2XaBJctghw3+sQ4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uWqmOL4mnowySy3wf7AGY22f+ud/HnVVItEgU04s9BXS9Z2bFdDVY2QxDo5OE7lgOXpNg5ivXuueVq1mgp5RnAs3vBVo8+xUJP7Neh40l93IlAiVcxbSIs5GDF4UFALJVgfd77VG3BvRnZI0FObQ+jAMwhxLPx2uXhG2R3LxqGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIL15r52; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762436332; x=1793972332;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EHpqxprjgPTrEK8uxt4T6opZkPg2XaBJctghw3+sQ4A=;
  b=UIL15r52luFkB9cjQYFyWC/04SdwdCE8Ch+oT0dY4zwgnwmk3efdYR5w
   uKAYomnM6zr657tHDa5c5k/aOc6ji2nVlM5XpH3FBc15p8B4YvnzJ7BUO
   xiO5ErV/yH532cWCQoq5Qb4ahKTrxZRR0I5kxvFVe8ZM8L0a+0tl4lKcb
   C6FPU/9Ba52xpUOH2VlNVvrbPurZzXaoHG/Rl0Uvkl7U+KoU/DM4+TiSS
   o97aUf5CBWWVjl1YAzMzt2A5pCM4GV5tq/R3USYVExxndhRrtAfpi1dyG
   BasQdhdLuBLjsq/b6rb9RvVWwRoRkgAlpnaj2cWVzWcYeo+xmRAAtO6b5
   g==;
X-CSE-ConnectionGUID: lsOOdTRjRJyux+NYqCrDxA==
X-CSE-MsgGUID: Oda92c9vT56DN9NlXKQw3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67182724"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="67182724"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 05:38:51 -0800
X-CSE-ConnectionGUID: iEP0DFn0SZmj+k47lxGUog==
X-CSE-MsgGUID: KkqaP1qvR3OFne0e8WwZyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="225008907"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 05:38:51 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:38:50 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 05:38:50 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 05:38:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA5mEdy107s6FfU4Ri13qtq8sl2xXh8oXCjqeJtogqDMk+t9y7YY0OFL003pjEa+LfYxVL//bHVRFSs6MIsZOrJyvZmTuJMhie4OTMAGMjhRFUmDAoifLSTNIe1y6wjz6zGVhaFWAnb2eR/0whaHtIIqiM0oWckra/qAhDaPzyiuvS3jzyoIjYHE1iyIN3RG7iFMvJ7qYIjQh5QtBtb+UuHEWEH7yE9EgZVuS3y9fX/b0dWiJszKOix8Gd61nLSSDDvWeCrVSDulY0AHFO4MrPf9JejouUlXuN5RfZ+BTvHhkiN1YcPXaopNLYISBK3m3x6shrfUq0366YBfq0HpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHpqxprjgPTrEK8uxt4T6opZkPg2XaBJctghw3+sQ4A=;
 b=VU7pyi3v5SGXE3ADQxLeY+yuFX2pjSUmKRiFwQEvn16kVb36ukA2N0Ndm7wb44OhqfZayc7XUqgw3nH+38NDkdOFYX4waJa37yGjh94N5PpaBkQdiYAtcbSrT5lEylRgdSHAePmiIairaH5noTsBBvrVWUk5WtS63+VOUAIdCEtgVeyKM7hgo8ryift1UXizDSNulQnrIyGlUYhsCN0T2HwTOO3mYDamWOu8jnqAFt7Nq0r5983G2MYVWqzLTnzB6bV8YW9BLgJPeQgC248UyLvaOE/NWvsYvkgkz5lauqdBcjGLQysFsgmQ9uBAAiVOHdfIAg5Sd3DOpYiSxpyYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DS0PR11MB8720.namprd11.prod.outlook.com (2603:10b6:8:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 13:38:47 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9275.013; Thu, 6 Nov 2025
 13:38:47 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Vlad Ilie <vladflorin.ilie@gmail.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck,
 Tony" <tony.luck@intel.com>
Subject: RE: [QUESTION] EDAC/igen6: Missing PCI ID for Intel "Arrow Lake-S"
 Host Bridge (8086:7d1a)
Thread-Topic: [QUESTION] EDAC/igen6: Missing PCI ID for Intel "Arrow Lake-S"
 Host Bridge (8086:7d1a)
Thread-Index: AQHcSy9g/Gywrj7UjkS6fvPT0JodZLTlqBsg
Date: Thu, 6 Nov 2025 13:38:47 +0000
Message-ID: <CY8PR11MB71343730A212569D99BFB82489C2A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <CALR5YtV3tiH8azka+d8=QiucMBCUTC5jOguScoioaDZg+-h35Q@mail.gmail.com>
In-Reply-To: <CALR5YtV3tiH8azka+d8=QiucMBCUTC5jOguScoioaDZg+-h35Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DS0PR11MB8720:EE_
x-ms-office365-filtering-correlation-id: 59bb5cba-ed13-4ba8-0faa-08de1d39d02e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?SStIKzJqVWVtZjFFd2JaejZkZVV0NlVFems5VStKRHd3TmRsZUdvZXpXdENJ?=
 =?utf-8?B?d3BLR1k5VU92MG9MT1Q3dXBSWTN0TlN1blV1NUNRUjgrRXlaWG5kUncvN3Br?=
 =?utf-8?B?cXg1dmVIeS8wam1yNGF0a2F4TkdReEhQL0Nsc3g1VmxpcHoxMms4c08yU2xO?=
 =?utf-8?B?N0VsbDkrdFZqa281clh2L0ROVkJqWkVxSUVzNUI0QmVRNmNnZzNUYUxmcFhV?=
 =?utf-8?B?RDVpSVpjUldFMFM4YWllV0xsaGJSOURoVTJLLzNIVDhxYUZoY2kzZld0UEh3?=
 =?utf-8?B?SGhha3Fqck5DbUo4NWd3djZEbDFwanpSaFFDQnVKSlNwSHVqbFZINVVuMWtl?=
 =?utf-8?B?aDI4bk9QdzZoNmhzU3RXZHpXYU8ybWo2QkFPeUxrMktFdU16Tkt3ekdLU2Rs?=
 =?utf-8?B?TG1LS2V5cERyQ0dmWnJWTkQwenNndHBlVStHZWhhMmpaYytCMEJUcDJyVVN2?=
 =?utf-8?B?U2lKblA0bUtyc0czTHZiNDE4YzF0V2xjbm9jU0o0UnAzclBnTm92bW5VM2lT?=
 =?utf-8?B?Snc5SGpzM25vRzdnaEtWcEtKcGZxUTFQOHpRSTVIcEZPbkdjdFp5VVZlU0J4?=
 =?utf-8?B?S0pKekpmTWdEUWNtaE5mQ25pbUhWTzF4OVc2ZlgxY3pndVFqNmNWdkR2RjVu?=
 =?utf-8?B?a3pEeXp5ME92T01JNEJSVTFSU2Q2d2tJNWtyblRHWE1Gc3ROYXpsTDd3N0xJ?=
 =?utf-8?B?OC9kdlJwU1AreDNSMXIvdFhoQnp6WmJTdHpCQ001NXdBZ0hLWVBmYmorL3V5?=
 =?utf-8?B?SWtaOUx0d2ZDQWJkdnFOa2tGbTlrS2hnUGdPZlFrcXdwNEd1SE1OdjFCQ0x3?=
 =?utf-8?B?QmJTY1dtY0tKTXYxYS9FM2JmanZsZ2Q5UXlKQTBHUlFENWNYb09hd05FZDJE?=
 =?utf-8?B?WG83bHcrUkc5RmluQVQ4akNDWm9raDJCandUYzJhZ0xMMUpxYWo1dWFqN3Vs?=
 =?utf-8?B?KzQxazY3bnQ0L3JkSTMwb0kwS3BPeDFHbWxiaVVPRGJKM3g3YWFQMlUwYTIz?=
 =?utf-8?B?Z0RBNVBXYXZBUE5mRXgrb0xGeitjSEdUUTdhSWlZR3ljVzQ4VW9DR3dNc3Y4?=
 =?utf-8?B?ejJ2bnh3UzVwQnhGTW13blhiK3VyTjc1aUdrTEpSOWQ1aEx1L1RYUm03REkw?=
 =?utf-8?B?RWhkcUx0WFRoUmI2OUZTejBvTWVURmtLaHYxQ0hZTFR6TzhNVWcxT1ljOHgr?=
 =?utf-8?B?eU0vaUNmQTZGWjlFZFBVeHhxTnZrMXZldmdwYldCSnJNYjZiSld2OFRxcm5t?=
 =?utf-8?B?MFdPUTJNWVZzZW4wK2hjdDVpU2V1ejNVQjNTMG1EbWtMby9lQ3F1eTVWZGFo?=
 =?utf-8?B?R0ZYb2Z4RU9iajcwbmdWUHlINGdIOVU0YkFTY2pHTmVtcklIMHV0UDNlRHo3?=
 =?utf-8?B?WFpVVkQzVkgvTUZZZEk5dVNaWGQ0UUxNODV2NWwxalI0ZlU1bVo3UC9NWSth?=
 =?utf-8?B?cC9PUlNYa0wzR0R5L0dVVko0QWRWcjVsYVc3UUEwdDdBTmdkVFkxa3ZNTkNH?=
 =?utf-8?B?MUlubUxweFNGT2F3aXhzRndBS0xJWGxSTjlkTmRIckhqQ2ZCS00vd093VWEr?=
 =?utf-8?B?K3dzRXI3Q0xUYWhiNWhsZTl0Zk9qRkVRSlI2UkhwTW90YjZHRmsxeGlKZ1lz?=
 =?utf-8?B?RkpHTUc4STRVVVAyOEwzZU5qVDlFcFNpZ3FoUEFSSXE1SWttTVlMUEFkQ1Ur?=
 =?utf-8?B?bFJGeTBLKzBpMXc4Y0FGKzdDYTF1UVlTTHhrYWhGMFpxUjQxZ2pyVm5SNGR4?=
 =?utf-8?B?Tkh1ZFlKUDFKQlRFL3RvODZwK2UwRlpVck1iRVpZUDFNL0liVDNzdDd1ckZY?=
 =?utf-8?B?NFdRUmhFTkFPaUplYUN4V3dqaTdoWjl1b1g5Mm4vaFJWekRZYWlTcDdnMTdr?=
 =?utf-8?B?MmhGYmlsV1pOMUdlR29iNXE3T1dLcmJZUy9qZktCYTM4WUN4WVIwajNYd2lF?=
 =?utf-8?B?b3pBSkdKV1UzOFJLMWxteUJXYUdaRWJ6TFlab2tXVGhJckZ3L2lMZUd2cWZY?=
 =?utf-8?B?TUJTM3FmZnZ1Smc1MTJVWk81amx2UDQ5RTMvanovZUVIbTZpZmVUdldaL1Vw?=
 =?utf-8?Q?LyqHA9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDA2MHZ5cDdTSW9zUGN3a1ZsQ3BnMlMxRFdLN2o5RjZ6d05PZHpOYlBNMmFE?=
 =?utf-8?B?UlRZR1ZkL2xMc3NvL01jekdQWTBEZFZpRDk0Q0ZOZCtmaDZqdnRyRGZ5SGZw?=
 =?utf-8?B?Z0lBdXdhZ05DZHcvS2U1aGhjWGFLWW1zZHV3ZWltbWV2THhOUjFkNGI1U2Zu?=
 =?utf-8?B?ZUhMVitUSnBLamxqMi8rVEQvYXJ2aUNRd1lhRk54aTE2TVBjbnlXd0pVRmFa?=
 =?utf-8?B?WFhveUZaQnpDZWNENzMrblQ5eWkrdHlsRnc5ZTd0ZGhjTEcxY0lpNndTT2Z4?=
 =?utf-8?B?S3dYazlNT0wvQ1F1blpiYnBmVzlxdDdFcUpZMVVab041clBLcng3TUJhTFpj?=
 =?utf-8?B?UkE2akN3V3kyN2N2aVFwR0NLcm1xMW11RVAzUlZLZy8vck8yeTNyOGNHOHFV?=
 =?utf-8?B?eGdZRFJBK0RBckxGaUVYRWFzR09kV2NCMXVNUHkzTEVxaVhuZVBvMU16M2Q1?=
 =?utf-8?B?Y2FIZ21zNTFBd2JNTmtpUStITGR2NFd6OGNkeC9Qd1ZMeWlYdmNlQTh3eGp0?=
 =?utf-8?B?WTREQ0RXZFArMkc2Y3Y3NWZtVGV6ekRaUTNlQ2o0TGJtSVJKaTdTQnl1UnUx?=
 =?utf-8?B?a2k2NEdkQU5vdURtMXUxSGtyN1VaUTczSUFVSlQwY1c4ZHB1am9KcU90bXF1?=
 =?utf-8?B?SmlRZGc1RUZWTlJSeGc3bHQ1ZDUvdU5wd2J6TTV3TTZ6Tm91S3E3WThnenlJ?=
 =?utf-8?B?MFZpeS9oTG1hdVRtbW5SK1lqVUxmREdQanpaVmc1VWhCeTBET3Y3Ky9NNUlD?=
 =?utf-8?B?UXBIcWx5cGVnSnFHemdxamxoZ1ZHRlNvWlNpTWVnaEJjQXgvbG5aaDdQaE9O?=
 =?utf-8?B?Z3dneU4zNDlTbVRxb0pTU01QV2lKL3dsM3JORGs3R1hpZzJsbDdjUmU0WmNo?=
 =?utf-8?B?R3dhN2JwMUdTbHNCdGZUNlk5NXllbGJpSmJUdStiR00wTlZBWHdDbktiQmhw?=
 =?utf-8?B?ckRXTnZMTnlzQ2x0UEdEcFN4U3padGtIdWFScm1uNnI5WG5pcDVLcktvUXlS?=
 =?utf-8?B?UWgwWGhVaFN6ZXo4Y3poY3AwWlZVVDVOT2x1UHlmN3BhK3RxYU9LSHVhbWJ5?=
 =?utf-8?B?ZXE4eUl3ZE5wWk5PTDR3VWxkZVN0b3g1amIxb3pLcC9jb05uVFErN2tQNTZW?=
 =?utf-8?B?ckN2VzlCYkt1SFJvdnZ0YzZCN0NxOU1abE8yemhSbU5tM1IyWTlHUC9EbkdK?=
 =?utf-8?B?emI1MEE5eUY0M3U4RzN3NkEzaWs2UzRTNXdDWG1PNFhxc2k0ZERyNm8reDNR?=
 =?utf-8?B?Uk42dVM2YkVGYXZZVE1YZy9wa21KU3lNRlNjaTBxRnNHQ2hLMmhsYUJIMXFy?=
 =?utf-8?B?c0pRZVJqMHhWTmdWOXRYbTBVM0ZxeGY4OXAzSjZxUkh1WXd2OFMxdGtya0ZW?=
 =?utf-8?B?OTA0bG5CVU12Yk1TTXhOUUdWQWJiK1dKZ0ExUDRqbnE3WWx1Y2V5aFlNNmtU?=
 =?utf-8?B?SE40SzhsNXkrVHZRNUpSeFhyMGtUUHZEZXR2bFdYdXJKZ2dwRGRpdW5TUk9s?=
 =?utf-8?B?eFV6UzZNQVlrV013bWNLb0t6N1JGNFlGU1I3cEQreWI3SGptR0dHU1BEd3Rh?=
 =?utf-8?B?ZmY0Y0gxc1kzaWtWb0NPSHRveVM4alBwYmlFOGU3NDMxaGJrTm1hSnVCWlZq?=
 =?utf-8?B?Rm1FMi9rNEgxMWFWQm5MK2Z4cVA5UExVRENTeW9IQjBDTjB2UHVubUhBanFk?=
 =?utf-8?B?VE9XYWlyN0o4YXNRTlhVbHk3UElkNmYzMUNOUm11cmI5SVYwZC9tZjUwUkhB?=
 =?utf-8?B?Yk5RUmwvblJ5TlFleUphbFhoWVJtSWpGYzNTaXVJS3V1aUlPcks2Tys1SFVh?=
 =?utf-8?B?TGdEem1BcVYvamlMNzNuWVJSZW9PRUhUa1E3My9QbFY0dSt4cXpXTHQ4YVN6?=
 =?utf-8?B?dm15MUJodnBOVXRSK1hlTDNBRGRpNlk1aXJwN01hbHBOYy84T3pDeTNETE5Y?=
 =?utf-8?B?RUtoS3VpNXlnM0w1TjFhYW9RQWttZUN5QUhjdWhDMWh5VEYxNzRhRVdpMlBv?=
 =?utf-8?B?TGsvQ3FvdlBGK25TVDZUcHN1aHhVd3J1NUNQZmlJUXU5OFhqcncxVUo0d0lq?=
 =?utf-8?B?OE96K3J3WEFubXpNdEtTekxKN1NwdkdPM3VHTFQ2UVIxSmVjR1A2VW93dDAx?=
 =?utf-8?Q?H50iy3zgXFAGoBE6C2zHS/6C4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bb5cba-ed13-4ba8-0faa-08de1d39d02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 13:38:47.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diK3g4XD/sxNpyRhbASfihKzaC8R3FJAQqameNjiu5ddYJhG1n3fIXs+oA3nPALU5dgUwI49KPU/Vm48pVDZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8720
X-OriginatorOrg: intel.com

PiBGcm9tOiBWbGFkIElsaWUgPHZsYWRmbG9yaW4uaWxpZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFNh
dHVyZGF5LCBOb3ZlbWJlciAxLCAyMDI1IDg6NTkgUE0NCj4gVG86IGxpbnV4LWVkYWNAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFtRVUVTVElPTl0gRURBQy9pZ2VuNjogTWlzc2luZyBQQ0kgSUQgZm9yIEludGVsICJBcnJvdyBM
YWtlLVMiIEhvc3QNCj4gQnJpZGdlICg4MDg2OjdkMWEpDQo+IA0KPiBIZWxsbywNCj4gDQo+IEkg
YW0gcnVubmluZyBhIHN5c3RlbSB3aXRoIGEgbmV3IEludGVsICJBcnJvdyBMYWtlLVMiIENQVSAo
Q29yZSBVbHRyYQ0KPiA5IDI4NVQpIG9uIGFuIEFTUm9jayBJTUItWDEzMTctMTBHIG1vdGhlcmJv
YXJkLCB3aGljaCBzdXBwb3J0cyBJbi1CYW5kDQo+IEVDQy4NCg0KRnJvbSBbMV0gIkVDQyBNZW1v
cnkgU3VwcG9ydGVkIFllcyIsIHRoaXMgQ1BVIHNob3VsZCBiZSB3aXRoIE91dC1vZi1CYW5kIEVD
Qywgbm90IEluLUJhbmQgRUNDLiANCg0KWzFdIGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50
L3d3dy91cy9lbi9wcm9kdWN0cy9za3UvMjQxMDU5L2ludGVsLWNvcmUtdWx0cmEtOS1wcm9jZXNz
b3ItMjg1dC0zNm0tY2FjaGUtdXAtdG8tNS00MC1naHovc3BlY2lmaWNhdGlvbnMuaHRtbD93YXBr
dz0lMjJBcnJvdyUyMExha2UtUyUyMiUyMENQVSUyMChDb3JlJTIwVWx0cmElMjA5JTIwMjg1VCkN
Cg0KPiANCj4gSSBoYXZlIGNvbmZpcm1lZCBFQ0MgaXMgZW5hYmxlZCBpbiB0aGUgQklPUywgYW5k
IGRtaWRlY29kZSByZXBvcnRzIGFuIDgwLWJpdA0KPiB0b3RhbCB3aWR0aCwgc28gdGhlIGhhcmR3
YXJlIGlzIGFjdGl2ZS4NCg0KV2hhdCBhcmUgdGhlIGl0ZW0gbmFtZXMgb2YgeW91ciBCSU9TIHNl
dHRpbmdzIGZvciBFQ0M/DQpJZiBpdCdzIEluLUJhbmQgRUNDLCB0aGVyZSBzaG91bGQgYmUgIklu
LUJhbmQgRUNDIiwgIklCRUNDIiwgb3Igc2ltaWxhciBzdHJpbmcgbmFtZXMuIA0KDQo+IA0KPiBI
b3dldmVyLCB0aGUgaWdlbjZfZWRhYyBkcml2ZXIgZmFpbHMgdG8gYXR0YWNoLCBhbmQgZWRhYy11
dGlsIHJlcG9ydHMgIk5vDQo+IG1lbW9yeSBjb250cm9sbGVycyBmb3VuZC4iDQo+IA0KDQppZ2Vu
Nl9lZGFjIGlzIHRoZSBFREFDIGRyaXZlciBmb3IgSW50ZWwgY2xpZW50IENQVXMgd2l0aCBJbi1C
YW5kIEVDQy4NCmllMzEyMDBfZWRhYyBpcyB0aGUgRURBQyBkcml2ZXIgZm9yIEludGVsIGNsaWVu
dCBDUFVzIHdpdGggT3V0LW9mLUJhbmQgRUNDLg0KDQo+IFsuLl0NCg==

