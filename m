Return-Path: <linux-edac+bounces-4617-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2018FB2CE5C
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 23:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D221189E88F
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 21:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E91310650;
	Tue, 19 Aug 2025 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiqxwWrv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659E2222C8;
	Tue, 19 Aug 2025 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637708; cv=fail; b=cOV+UYWQ7KM17/WndXQA1H09vlUu1msgIAAkBAJ+YUkjf1EPrakAVmvRRVOmc9OuvAKtFroqzDwHYewvj8s/JwyOjqVeKXd+oYbe9Y1gO4+kQhNyub8N9PDpYauRj1bi2yNKLGKVHJdh4YteUfQ5ix/AHqgEb9Ch5qqLMaVGs+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637708; c=relaxed/simple;
	bh=dEgDmZZlegvIlBD2V+x1zgUy2SBKDJSIAnQBoz0c+/8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zt2JMdqhUTMKtk895jtA1V7+UwBVNPkoPLt/QAYefbK8VN8H6j5t8oflhmaME9rElneyTbOom66k4Pg3M4FH3+KAwbF/RayzDF9VxeCeA7GA+wi31/iDqyxSXseTKMEseifOMOiUL4POU2jqED+aqZxq2GWzfzmdE+7Wg/onDQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiqxwWrv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755637707; x=1787173707;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dEgDmZZlegvIlBD2V+x1zgUy2SBKDJSIAnQBoz0c+/8=;
  b=iiqxwWrv8zGTtbFPt/lWK0SioQSZauh8axvmGo6p674U//7yMF+uzMA7
   I6CfajlJegi8Kr67/abaeSWkc50PuEghJQ4XV7TFc6E5Cu6y30fseT+bU
   +yajbkXJJIJKquAr2WgIkhxcSIZf+8fyqPlNj06JvD7y1OYVDHp7N9tkG
   94pD/PDvdozzuPjgjDCayL/hqUbjXN2FNU+319ZbDBqYaphJeQtd80H7p
   gQSd+lw7NddPgSeU0UqD4OXKN42UNlx6xzGBnAbaT5Qk8xjSWubPOnqTc
   CHK0K5XR9ix0waaccU6S6MlnBfRH74yeo0vA/J9VAttIIx7ND2xF9RJho
   w==;
X-CSE-ConnectionGUID: oYjEuEHpTvCV3rvnMC4UmA==
X-CSE-MsgGUID: lzzkJaaRRE690FCAtTkAdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61529765"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61529765"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 14:08:27 -0700
X-CSE-ConnectionGUID: bUcdYJY0RWW0AOT+YF5NVA==
X-CSE-MsgGUID: WhfsdnrGQI61KWbp8gNfrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168203382"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 14:08:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 14:08:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 14:08:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 14:08:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIOpXgvV96MfAUyy/S+3gySJzRuvFEHwtv0USMX4SSiESZsX3ZWB7dvaGB3ZUjPelN1Qa5jNxs3glbwZjt3L2+wowN1FQ3bunTX0hpXPJTpV93iLTZ038PKLJ7DS6w/f3xN84EwyVorUS8/I6ke6/T4RYOOXVeKFS3ZGzcNyid/8KHKD3dR0C2CR71A4hcm1ra4SQDWNo03APYahGRtn6pbYc0rsP/noEtLn+RPnRRgVQMZYHYby2aXeRbSxFC2oUJLu7la69j5bvXbXqNMjOmt89Vc07A60gUeQ0FW9plZXj2FWcYGbERxhYkU1ZnTrueVITw9rXGWs6Bx2TDRKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXlWFHElYLCZI8F1Q3Ev5CIZS28gvBQ4ahOx4F/N/Xw=;
 b=LYloN7hDZSkXSWxuIKsdyDvsMQTcuQ1BsBVM+WklPWDgYSWrSXPnWkTZuKHkrl9BKXQ8qX/UqmNEAAiLWXANUxO9gnYaj3n+P0My/WA24r+pEO7ivKupNSlMZdyYexEmd+jToJ7Y6uLof/ghZTOH6c18cLVb/queW2rCE5vUr84odlRbrb7h58MXuW/RCSZ1AgR4kk5ink02vRwjFdyog1Mu+g/DiFbQDcF5U3cJpeUTAm2gvHF22i3osMOfDxXC1ovICYb74qmLEHNLo/lc/WMDyUDTMOseLx+4o27idI7zSZcRxjBWBKe7csrAvFibLLDhtZhG9XtBp+7dLyK73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA4PR11MB9011.namprd11.prod.outlook.com (2603:10b6:208:56b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Tue, 19 Aug
 2025 21:08:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9031.014; Tue, 19 Aug 2025
 21:08:21 +0000
Date: Tue, 19 Aug 2025 14:08:19 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Kyle Manna <kyle@kylemanna.com>
CC: Borislav Petkov <bp@alien8.de>, Jason Baron <jbaron@akamai.com>, "Qiuxu
 Zhuo" <qiuxu.zhuo@intel.com>, James Jernigan <jameswestonjernigan@gmail.com>,
	James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>, Yi Lai
	<yi1.lai@intel.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] EDAC/ie31200: Add two more Intel Alder Lake-S
 SoCs for EDAC support
Message-ID: <aKTnw7x0FrGfYW_q@agluck-desk3>
References: <20250819161739.3241152-1-kyle@kylemanna.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819161739.3241152-1-kyle@kylemanna.com>
X-ClientProxiedBy: BY5PR17CA0072.namprd17.prod.outlook.com
 (2603:10b6:a03:167::49) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|IA4PR11MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6f586a-c512-472c-fb96-08dddf648747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEVSa1djeU1UZlRzaXNSclZ4Ri8xTWp5STJVU05XazdVZDFHTWN4YStoNlZ5?=
 =?utf-8?B?bVhkSGJ6NmhGRlltQkEwS1VoYWUxb1h4S3J3Y0QvbHlsWGVJZU9rRFFYRFdx?=
 =?utf-8?B?NUUwUXZHRW9uK0YwaUpObmlKaGtXR3ZJU0FyZGdnUlgyaDU2RmdFdWVEUmxF?=
 =?utf-8?B?ZSt4OEdySXcrckE5ZkJKUTc0QlUvS1l5ZlFoS08wK0VjU2NjOUJCV0Fob3dW?=
 =?utf-8?B?OUE4TEJZc0FDa0RxbGN5MlNYUnp3c21EckpsbnFwQ2hzZmJBMnY3OTIrMmV5?=
 =?utf-8?B?YmJpbUZNVTZxcW1RV2s1aXVzOWFYdDluVEJBUVdtNHNVMVc0NmRIQnh3d2o0?=
 =?utf-8?B?WERaWldBN1ZjTE9GN3ROTlE2SlN5WEphL3ZtYmg0Ris3YnJiWXJDM0p3emYz?=
 =?utf-8?B?NTEwSEJqRDJpR1NMMmo5cVJJZnloaW9kS3cxQjVVaDBFT3R5M2x5YWJYbHV3?=
 =?utf-8?B?MHZVWkVlU0NLUUpUc2tPRVdKTThFUUdDeGNPbGxyajh2cHc1dkpTa2VXa0lY?=
 =?utf-8?B?bWNGek51cmR3VWI3WXhwUkYyT2loYmZ5M2hUd1Y1Y0dNbk5JYi9ic3hYdm1r?=
 =?utf-8?B?OXBEQ2s4aXEwQzl6eGVmYmw5RWhOWnhxQXJVZ2FpZUR4TkwzdjN3ZnV3NW1Z?=
 =?utf-8?B?bzVtcENwTDl4U05ONzJXSVBwMXphaVloWTVLVHNWU1JXNnZuZGxSSVJKK0kv?=
 =?utf-8?B?MkR4TW1SSE1mM3o1czIxU1hlNTAxV21ZdG84Q0s2Y3RIVlJ5TnBmUHF6VGlz?=
 =?utf-8?B?YUR1SDF6NEw2WmRNeFFZb1ZsYTMyUEFjQnVzK3hKQWxTbDg3M3RCNFloRTFj?=
 =?utf-8?B?RGs3K01lb2RheVppYUlaNVROQWgvSHJuaGdtLzN0c1hudTVyV3FKZkQ4VXZo?=
 =?utf-8?B?VSswTHAxQi9uOExyR00zK09VSjdha2FFZndreUp5T0lqWmpiWDhDQWdScEpE?=
 =?utf-8?B?dVd0K0lQVW1KRmlmUmg0OFVwbmVZOVhQSTNwUm5KM2dKdzQzZXRBcVpaRUgv?=
 =?utf-8?B?NWpaaDl6Rk1JZmkvNFVqTk5rUzJSUzhRV1oyd2p5Q0loOHE4MVVSOGpqUXRm?=
 =?utf-8?B?bGZrbFdkRkdCL0ZpM0FwYlNxUUJ6THFxKzQvWU5zemNlOElyanFCRnlmU3l0?=
 =?utf-8?B?cVUwU2ZobHk2empHdjZWM1JqbUttSXBmQnBQbDQvSmh4cktpWS9PWUp1Wmor?=
 =?utf-8?B?V0M4M2VjVGJ6VVN1U3hYdG1lQmxlK1RhQnlCTmY1blBMTThNZnJJUURHRGlS?=
 =?utf-8?B?YUpGd1h3ZThGd2hadnpJVmNFakNDM0IzR3pRVjFRVytxYWdDQkd3VEdnbHJs?=
 =?utf-8?B?TkhGc3BUdWphN3laMmk2dkwySUE0TU5LNnR5STdGa0JMb0VaUWZzbEFvYzM2?=
 =?utf-8?B?Y0xybEZyd2g4ZU5hbUJqUExDMmRHYjJtVFlHNEkwNis0U1hRcWtXbkRCV2JT?=
 =?utf-8?B?Mk1pNldoWENlYlRDVkxka1RaNzJ1TUtrbmY1Y1B2NmhrRWtCczY4eUNFb3R4?=
 =?utf-8?B?RjlwV0xXSUlRQjBIZU43bzNQeDNiUEZJYWw4em5HdVFPdmdrWnpIU0cyTU1z?=
 =?utf-8?B?QkNJMzRoZVRNS1NSZnY3K2xwTDdkT0UwMlZQcjhiWmxjTHlGeVVsd2ZNZkdF?=
 =?utf-8?B?aDd0ZnNzUTVQbU1sd1M5cWtKMlpEWUtoLzJQeXJ4TkRuQ0I5a29QZ1ArL1hO?=
 =?utf-8?B?TkREUVRJMm1SNTdnU3FRWGJJcHRuTEE4eXpSREgwbTB5eVRzNy9adVdYVXVE?=
 =?utf-8?B?V3VUYjYvamxoY0gvcDlxYW1pMlZYcnFBQWdUL1U5VjZyUmdnaWExaWZmRGRZ?=
 =?utf-8?B?MGhkQnNScUJhM3NpbVJoZUFaNTBSaFNHM1BjNElZUExpMWI3Tm13S0I2M3VM?=
 =?utf-8?Q?TKDhAdM27xrXH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0VGUHJmQlphUlF1Z2xDR240N2h6NkpqK2txR25rMjdLR2FXNUNpeGRNUGMw?=
 =?utf-8?B?NXplOXY3ZDErTEFvZjh1Y1NySGd2NnFjbVJQbnRjTS83RXBIdkplTkt2ZEVx?=
 =?utf-8?B?VVgxNGcySEFwQVBOcCtvcDdxZWNJa25xbkd6RktadFpPcHpoTHR1N3d3MFpT?=
 =?utf-8?B?RSs2YTBJSEh3MFNpQVpiZFBmRWlEMU9sVytEQ0tndEFudEJFWXpGY1VWem93?=
 =?utf-8?B?bmdrN1I0T2NRVnMxa0tBY1BTbkxIZ0JXc3VGdkFpbS9Bbm5LOWptNy85RTcr?=
 =?utf-8?B?QlI4aTdYUE5NVUlURUQvaUJEbDZvc0JKSzc4MkZlVDV1Sk1aQUxsNFNNdCs0?=
 =?utf-8?B?OGJYT2ZDSitaWUd3ZWJjU3dkNmtPaEpoUDZsNUxhZGJWdG5oWU5xRVRHcFE4?=
 =?utf-8?B?b0hlNWtIdzhiQy83djlqM0tTSFh6ZTExR0NyelR4a016NmdkRWJ6ZVRpeE5i?=
 =?utf-8?B?YTZDZGRnaG84WDdlSFR2UFJXUWF3MzlEdGVSa3FWY0ZtVWdaQ1J4ajhXNko5?=
 =?utf-8?B?cisvSWxrczQrUXRxRHBFdjdRZWNuOENrbngwOW5aQm9nVkVtWk9kakpMOHFs?=
 =?utf-8?B?dUlSbHZEUUZYNFgydFI0RWozOEVlWXJRaVlMYXc5OS9qcDhWL0FHZG9Ud2l4?=
 =?utf-8?B?dmZSSUxsemYzczB3a0YvVWg1QnJmcUFtcWlsNm5kZUM1Zk5hK3I3U2lCdTBp?=
 =?utf-8?B?MDB2YUJhYlN4YTZCeHloRUNKL3BZUWlDZCtvVU1nYm4rZHYzVUtmalVoSGZZ?=
 =?utf-8?B?M0IrcGdqSkpVVnhldG9ROWxxUmVWenZ2UmVCWEs5dk1wUzhCb0x6T0RtcHJt?=
 =?utf-8?B?OTlHNzlGSk1DR0pXWmY0N0k2ZWtWdzlid1NXVFhpMkdQcVdiSnhTTyt3N1JQ?=
 =?utf-8?B?UWNuY3M0bnJvenRNY1dITlR6VS9YbXZwNUZRMDRJZEI2d29OajYzeUxEeEMx?=
 =?utf-8?B?ODBkdk1LZ1h1Yy9JcnIvdHpOb1BqRkxyN3VpbURNSWVDR2ZGcGpnSW5waDNy?=
 =?utf-8?B?bDJIR0R1U0FUZjNvenhleTdUN1VnUytmRXlSQkxXSTRZeENMY2x0TU5xeEYy?=
 =?utf-8?B?RUZmak1yZTlyclhUMjFENmwyOWVLbHhFcjN4ZGVHcEk3aFgyZ09mamU5SWxu?=
 =?utf-8?B?V0tuR0U5bjBOT2xtcHZySmNSWjFpaU9CaFhRMHRFaTRoV1krencwL1Fmd3Fp?=
 =?utf-8?B?Wkw1TDVRMkZnUjdXaG1zVmJ2SCtpbk0yM3J1OW5RVEpNKzRRWEJQZEYxNU9I?=
 =?utf-8?B?OURBSWZLTHZRVDgvTW9uVjBWUGF2U2VwY2pVUUdVa3l0aXRlaDZYVW5nU0Yz?=
 =?utf-8?B?UEFKTEw1b0I0bEk3b0t2Wmh5aDVlWHIvN1pyOUp2NVlTM0hrYnhWRUNlSHV0?=
 =?utf-8?B?Uk9sTXJ3TU9FMWpVeVZ0Undmbk9CRmFUWUNpNm9GT3JLSElieldEb1QxdWNj?=
 =?utf-8?B?dWd3WGMxRm9uTUVhbTVZT3pQZnJGakpnelBnekVtc2RpdGp5U3Nvd1hBbVdp?=
 =?utf-8?B?RzhzbldycXRGRk9xQ3NiK1JCdTVoZGNybHVucFF3VExpeXdDemlyL3N3aFAx?=
 =?utf-8?B?eWllT0s4MDRMMiswRzM1OTdjTTFCV1M4MFFNN1YrL2FFWTRvOFlSbEYwQ3dv?=
 =?utf-8?B?em9LK21tVTFkOXlYZ1ZqTHJUSVd1QnV6d0lGQmtXZ0xYMmZERlNRaGlHYWgx?=
 =?utf-8?B?TGJRYzk1RU5EbGhENEo1eGxhb0R0YXpwNVpsR3lQTG5GazZnbVFEcjR3dEYy?=
 =?utf-8?B?dk9qSG0va3Z5N2cra1gyWndYbXVYSm8yRy9zTVl2WldWai83b1VFYVpRSWVl?=
 =?utf-8?B?bGREb25zMkpUeTd0dWdDUEJIQ3VKK0RUam56U1FYYk50QTdTeDNmczRGL0I4?=
 =?utf-8?B?cG9iSG5yMjdNaFFkNWVOMENQVEdKbmdyYXYxd1oxQVN6VkVybU9OSVQydS9i?=
 =?utf-8?B?aFEybUZZTjVmRjVPQmtzK0M2MzAyK1BGbnVkK3R0MlVhdm13dXFRcjRiRGM1?=
 =?utf-8?B?WVJwWjh2WGFwVXFKazlTSjlYbDlNTGNQNGdTZ0hOVmcvMW42UDBvM2dxT0pD?=
 =?utf-8?B?ZFhaMHU4bFNESlJuZ2lyajJIOEpLVTJPMnNzRkhidGxYSjljanR2UDhQTEtE?=
 =?utf-8?Q?BBhMjxPbrnQyp9pWHfcSY2uZb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6f586a-c512-472c-fb96-08dddf648747
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 21:08:21.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGnRL5owPD/06Pf6oH/jVHeF/C+5o3bFmPtgqSURuJlpL2hXi8mBDBSLoxi/dgJeUW4UFi9jNdGu7QnFI7zMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9011
X-OriginatorOrg: intel.com

On Tue, Aug 19, 2025 at 09:17:39AM -0700, Kyle Manna wrote:
> Host Device IDs (DID0) correspond to:
> * Intel Core i7-12700K
> * Intel Core i5-12600K
> 
> See documentation:
> * 12th Generation Intel® Core™ Processors Datasheet
>     * Volume 1 of 2, Doc. No.: 655258, Rev.: 011
>     * https://edc.intel.com/output/DownloadPdfDocument?id=8297 (PDF)
> 
> Signed-off-by: Kyle Manna <kyle@kylemanna.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Applied to edac-drivers branch of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git

Thanks

-Tony

