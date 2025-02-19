Return-Path: <linux-edac+bounces-3154-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF8A3C43D
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 16:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B64174818
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BB51FCD13;
	Wed, 19 Feb 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vcDKkNfF"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090C1F5859;
	Wed, 19 Feb 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980404; cv=fail; b=CsJrdAPh2Sf2TgukYr/hMD3BSsQYChQ1otp6uIGdBzP4Bk7mqH0jng1GgE33PEXAFQgQ6fqyod4CUAFVHvHY6bxvm6FWltlk4as9aSdAolr+tSij0rOkJhkHFYxeh3mUauLPodH0ziio9xWIpCOSdqQlfzzxOO9M29CEJwP74Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980404; c=relaxed/simple;
	bh=2qK9T9qqyraw0asf1G/mYDxmF2KP7loxA9evgMASqM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DPvvHb+dqs9MZiNjTSoFsEFTB//gsfbATPF9sJlLqk/2NM+uRB56D7gPgclFyxSbBxYzswSqoBQYfUKieU5vdBzPv7+RGbOplWS4ohCHffZh+eHzxRq16IkGH+W6zM5oyE/36ItxBCGIgfQ8vnTBJsJTjQgE13idOP6XWWkPCtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vcDKkNfF; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOYcBGFD1nHaHzOgxQqA0YIXYg9k9I1+6eiHhSyk7teLPUKATIdnw2a0eIXF2yQBFWMHg/OJt7o6gxqglnO/vEnT+lWzr8OEDBxiGTUlCJ2IaJ7oOFs/TUe4XGuGbnresj9exuBcxtZP8uhDjL4t0KZ4L0BuCSiwgbSIs76OTkYnCOk9ncIS6BnxJieO12fT6TxyJYP016PnBeqGrpbp6W1roKkKoUCUC81rU4SUQw/eEivEcyMq+xxw1CEC8QcO8wOse7IoDBPVj/g87Cp4BzvAugBBSTstiTtu9u6B4zkpm93c0LdAui36qqPGZ2LihxeRi5pQhEmLvxJfzTno7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4dS53r1i457NPkhJdN/FM8lESHPut5GJFmtX2Mi+6I=;
 b=dKF6IGUYKvp77gVOcq1Aq9wQJyPaAqIVfO7FXvpJexKSrql5mBbC06q7pEa2gam1W2wm2H6AfPuamlewfPYPymu/XElunNZ9x5gpuu+g6fdCbc7I5mDDtGfK19K6SnxI2sLHqsqEeAYmTvV9p+86q4N77vIkMo9boKWv+ohQEoMLXUE509gxD93AmMGkOHyoVrFe60ydA6SfV493DeVxIME1KfJ8jL9qn4l9PlbDE48RHWBlp7vq5lObejkP0Pg0XTgeJvsB4w32Q4CWqM8vEGY8aOTiEL62S4XCUgLLRNQSijpqGvr9fs7uU+7xULOINZw5ixyFU+U2ML3GsboFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4dS53r1i457NPkhJdN/FM8lESHPut5GJFmtX2Mi+6I=;
 b=vcDKkNfF3/qzMNQC84cni5NNOhNs2Jt1VxPZqf/D8WkF4/JerG5vdQgvT3s0mPRKQ18pymJYG7kBSPPwwX9D7LlqFtp5+KEnctq+gg6euJGrb2I3Jo+qfLicHINaadDe5jb22878svjZ2tKx7kCtF6llJju2h1+KgjEZ4TSWiIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Wed, 19 Feb
 2025 15:53:21 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:53:21 +0000
Date: Wed, 19 Feb 2025 10:53:17 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
Message-ID: <20250219155317.GA337534@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com>
 <CY8PR11MB7134FBAFC4CC37B06C9AE7ED89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134FBAFC4CC37B06C9AE7ED89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL6PEPF0001640C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:13) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: cda2abb6-1a88-47f4-dc4a-08dd50fd88e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBIMtWG7DqAovbKFnPuvL4dDQ0QztFcINM6Zxj2MG11mpcz5HDYkwepRzEtd?=
 =?us-ascii?Q?OriXr1sWWNKvojXVr7bLXAo94Wi2XnQTmp/A0vW0L7ubZLwcvCXXFD5OrVps?=
 =?us-ascii?Q?3C4Vwu9sXEnH86FOPSy7M/J4Bgzs9Mn/9NrxPcDOE3CEs7FGjl55HMoLtpAa?=
 =?us-ascii?Q?Ofs09HHMXBX2YTC3a5z7hkDYrPtf1fxvwE78wWZ8fR/lOoGgMxQU4V+p6zeC?=
 =?us-ascii?Q?IrG79Ti/yIGsR3WTbacCS35+qWaK01mE7VpZGFICrzMWQmZje82vxMQvwO3D?=
 =?us-ascii?Q?oQcdHUG8M3eUBXz/dCAnJikCcaQJ4TvhOTWOPu6HlhhBk1zD2g0z2aCbdSFp?=
 =?us-ascii?Q?N4UJihAdZD+fIWI3d/BDfiOYtXtth7/J/Mkg0hA3zkfwQv21SmpqRMyIYkSA?=
 =?us-ascii?Q?+0vKeQtYgyTn3DyvEu+9v0g3IhV5kLwI8EJ15f3MWoDuwQASGZy0opmm6ZAB?=
 =?us-ascii?Q?qyJdiRqcoaE1SEYk6+01XQyYTISJCh7OIzFZVYn+XVhmnTVNzGaWQEVDp3ES?=
 =?us-ascii?Q?LPmH8nzOIflY9Wza4Y810olX4sqE5fJXNiGVVRm4lXaz1c+3vW8WLTw7t8/9?=
 =?us-ascii?Q?vV1R85NtwOyzDUc3QoZoM2XmSyppGXDRDHXzLY230+djYeo9jPFEIie4Idn8?=
 =?us-ascii?Q?iGPyC6vXhQlB/JcL6xwhv7GupnRTCGTTHFHx9F2YjNp7O+npryGGcZx76HgF?=
 =?us-ascii?Q?6024pzzxxV3J0yl8rgcqZ40alPjQuaW0mayis+KQ9YUTppAUO4G/j2JGs8Tx?=
 =?us-ascii?Q?20Swlb8XH/wIofLySi9ohDmu2mpmW3vvV7yByc32zH/Ntxz68tor2+bXdyU0?=
 =?us-ascii?Q?Fy7q5lyI7INdup1l+7dZ//sS6gRALbSrSLMbP79qtSMvw/76Nx6ZJOIbfpY+?=
 =?us-ascii?Q?+g0orXGnINunnEHT42CX6pDT1Ef0Z4R5MgMuCrkfPij6gdGgoy924MHfmvN1?=
 =?us-ascii?Q?bsiRnXOYbmygkp7OnPSDyXjgxNMeMdR/nJb6E9j5mXcmaqpt0MwXvRRk+8y0?=
 =?us-ascii?Q?X5NPo1EWsMCETajCON7vmdgfM29CUmajlgg4F97QN4KCtcAoiavYaprS+Hw4?=
 =?us-ascii?Q?2woSQZ73XXBtB5g6rjuQN1Ppp2SPRWQHo4apvJP4AtGkJIxjEOKQEWpDhIMe?=
 =?us-ascii?Q?eH6tOYDNTTOluWzfKGdZV8oK3u7SNoYK/eoD6zvhanxc0y7Njxf02oBfWTnV?=
 =?us-ascii?Q?AQLFBdZu+lbS0rAjRfSioC1Et1tBlDXeu7bt0wl/zFlwru5Rja7o//zgnldt?=
 =?us-ascii?Q?alFgh4bLSllZY5TRMU7NNsmavJetbGkkBt857ZebmlTNY9t9muwpHgi7MaWW?=
 =?us-ascii?Q?/N6tdxulhB9lDCXHWmMZZ+oj6CypEidhoEmaPc5GNrLXIxsMGM949Lr1XoWK?=
 =?us-ascii?Q?bVKCLi76G9a4fnBAIBRgacKhAlsi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cixY2kaZ1hWVzBuJMoEcyoynb8dEQEXufkvsTc+GriYvxmy9oJ5cT6fZtI69?=
 =?us-ascii?Q?Z+3aAJzFehVi3DSKu6OSR8RMcQh142mAG8I3KunMGghdTHvnTM/j/iXoVJDf?=
 =?us-ascii?Q?LJYFessyIE+jjgX/G3vIhievf+oxVQd2rHTu1nfpLGwpDjYqxTWJT3Cjlss4?=
 =?us-ascii?Q?twBos20ZZvo1Zu98x6z+PFlwxoG0uSJR72nLjMtTyS5s434EONs6TQ8kUXRo?=
 =?us-ascii?Q?axkjVS/Pqry3thNsOA9QEd1JWviwA6pkN7m+70ArVmWLKSwqgjfF3i1HiKqI?=
 =?us-ascii?Q?ZHuAxe28nCpgKqEvYFtBJoyZvWN5JPmp8YIMWp86S+AyGjQDKJNC/Aovss5V?=
 =?us-ascii?Q?vuP8RdOPl5XXJp5MFoUpNnP8wdz2BrRBCwW9IUu/fcwL3ZGNPNvAbHRQ74hL?=
 =?us-ascii?Q?PI3UUwazhsNDRR85QMeJ+zvVYiSFE0vCtuMKMInLffYQFqoBBrFPaKUkLFAz?=
 =?us-ascii?Q?Aw3FPa9U34wuq2T+pLmC7aO9SCTqPKCDsJ1pD8cgnrdNHHhPHsy+chuq/x0p?=
 =?us-ascii?Q?AIdIA0BIBe0/h60pLuAUuOdTXsqtLy2IDHY3kKe7L8zj7srGFS6/Kj6m/eYk?=
 =?us-ascii?Q?D7nMdQsI7HxKPo12uWJARyvx2CbS5D24JSmAPgYAXYnMwa6mkbskJnhXZWPX?=
 =?us-ascii?Q?mk0MlMLusKaqQhVquzutHnuukLMseEThAmu1kLO51KoYBaYS9YNRFBjTGh8z?=
 =?us-ascii?Q?HmtXF0DVyCXY+/Ja94713M1YQkhGFngx4wgyQz3ABbWK4X6NcIl/1FJDMIFN?=
 =?us-ascii?Q?51TWGLSH4XgojDiaChN2GrvoVgMehqOmGogxLUJjZSwkqI+IIaXY7rLuFyOJ?=
 =?us-ascii?Q?7+MZTEtZiscSDhtcMEbfVoKFLZ8qAIoevvXFwv6mOV7o4fjEeIV/2pdl1AhV?=
 =?us-ascii?Q?XKvv1cGZm67BqUV8BFKFnfw+8b/SQ6MvIWz1HIIF6Z2cfvvkJbaC+giylavi?=
 =?us-ascii?Q?Q7JCNuDnLIW75/FrTGvfEEO57tqUM3DN8sTPJVCNBf1Xe8GDg/ZC7lwUIh9t?=
 =?us-ascii?Q?7RS7hhGxMoQDvYikwPhrvhNLpRfF8XamezVfJyOwBGXTT5Gjx+do7VnOrm/B?=
 =?us-ascii?Q?0d67ke+GKsDR7VeiivltLPy/skOebTa6mmZvTnB1Jp2W1QIWOeAVfQp/HQxh?=
 =?us-ascii?Q?xmkrDUxvxniCTtd3H0xKBob5IVNMRjLQgoa+aWcHMdviuMSTTZ7dNYdBQ7tb?=
 =?us-ascii?Q?vdvPmbKsq4wbGhwzInTICnKAXtEovRXOhCD9r0Uuiy+dPHIXY/G5az+5tKZo?=
 =?us-ascii?Q?YavsAIlQM0pWXNPF1/DwfreSmuNiWQ57Tw2yQ8pIuQUOjA98Yk2ROunPeK1q?=
 =?us-ascii?Q?cVHxU+bgUWv3ckjnWl34oRzZsSNR9yqGv50F7+i1RjlDven5vYUJbqAw/+SP?=
 =?us-ascii?Q?lG2BXMZfSxFixaoi6wr1oxZZdvYw/d9qSsvgn8UYW3/M3JRV9pRfgtGXhz2i?=
 =?us-ascii?Q?R8vL6d5EGrT2StbBwLCflLRePJMPDDEvhCZqtRqr5VKGRULNiFwyMc9QVRpu?=
 =?us-ascii?Q?WSmU0LoRG+thfX+LekIb+M1/vKlc/arh3s9betJ2ZVE3pDmcz6sjDT8KTFKJ?=
 =?us-ascii?Q?807OUDPZ58VMprAuQ7mgs4xTVnk6pIPnl8xmMHHp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda2abb6-1a88-47f4-dc4a-08dd50fd88e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:53:21.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRoMYQAcj3FixW9cyM/pPuSqk8/VYS9uIw5DODcyP/KQ6Yyw7e7Ri0MH8JAdwtjlpDs6K9/haNm+M7YuVHhnog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741

On Tue, Feb 18, 2025 at 03:00:12AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > Sent: Friday, February 14, 2025 12:46 AM
> > To: x86@kernel.org; Luck, Tony <tony.luck@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org;
> > Smita.KoralahalliChannabasappa@amd.com; Yazen Ghannam
> > <yazen.ghannam@amd.com>
> > Subject: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
> > 
> > The __mcheck_cpu_init_early() function was introduced so that some
> > vendor-specific features are detected before the first MCA polling event done
> > in __mcheck_cpu_init_generic().
> > 
> > Currently, __mcheck_cpu_init_early() is only used on AMD-based systems
> > and additional code will be needed to support various system configurations.
> > 
> > However, the current and future vendor-specific code should be done during
> > vendor init. This keeps all the vendor code in a common location and
> > simplifies the generic init flow.
> > 
> > Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().
> > Also, move __mcheck_cpu_init_generic() after
> > __mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
> > MCA polling event.
> 
> Maybe providing a bit more information about the first MCA polling event, 
> as shown below, would be clearer:
> 
>    "... so that MCA is enabled after the first MCA polling event for the machine 
>     checks left over from the previous reset."
> 

Sure thing.

> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Other than that,
> 
>     Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>   

Thanks,
Yazen

