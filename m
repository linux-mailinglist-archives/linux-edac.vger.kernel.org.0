Return-Path: <linux-edac+bounces-4715-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5C4B404A2
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 15:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5B55E4C7C
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B88A33CEBC;
	Tue,  2 Sep 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CEnfDRkv"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B833CEB1;
	Tue,  2 Sep 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820244; cv=fail; b=MWMrJyk6MkrD/af9WT0r0CyzhVJ7EZ7ABpPcPHheVje85iyQ95aJOZFrSQhW9OqxtyigQWPrQQUjx8PQU3I6hkUkSVAO5a5IC3WdMl2/GgdpcNB2kZoV+MZ2ElB8hix7tVV2pM+6DkofFv0V2N5jqtHC0NiwT39aKvtzHSBFHaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820244; c=relaxed/simple;
	bh=iBheGswDiH+2oKSX7zFNpISh+JXQ8jNAmlZHw8tJyms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qD+YjBooPwRvPn8F7zQp3xJKEBVLfP44eaO3v/dNSH+OFhnVEOcwGLc3rY/KGMS3v5NJrYHqD8eTkWAOn5A+FjGvTq0l/KB6NJDZS1WYDo1t7k/ZWn5AS3NReIFlTqhEtpuPo9pmW7hKhUWTx3mWEPybGNNI+jjJdsgHZ/5mc/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CEnfDRkv; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwIzdh/Dc6YTZLbHJXCIVCROzrczxroFe/AEfhsrnbRFm6peggC4/fpCCfL9nLg8LfROQZ9YRqTee7PXhWfNBpilbSr9g/FjKzaV9vTIgp09aal1pSEqIqNxeJDzRqNji73XPvWFneQtuAZBmkTix5dmPVv1ekS0nS6bqD1E1rlVn/Jdk2dgdGfvKBE1x3tjlcUWeiYNNVEddJC3TrpbB9bGqC8emaS8CMna0C7tX0xuY2rBcUpoqdO8+m9kBnAZ6i2jQM2zIJ22rNm6Ic/ipr9PmM43xPzjnN/vOqnAVNBEvFUbR+pAsZTzmUxW+GEFWG48lUAxTExBlEA1YshYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csxxnR/bWcbUB74lys09IHo53uexc0mnepHLsVzZUt0=;
 b=pYiKMr87GlqEUYr9PauSswYDOJdqeuYyC5RbwenzfJ/qYcTIt+YudGtoYRJO27hxafHU1F4Jga4Y9wRy6raugukyajLCeAFkwzNRkJDP0m35vA53j7nA3fBW6567TVknLFTZGUF7dk3Onrf8kSh0LM9jEHMMjxNTSynathZ8AfzSYr6wPrNYwzAf2VdOW1zza7aFmtxcWrrwMY0JsCudEiioCkuqg0UxOXjBm6Hc9JmO5tDgo2TOfMQewkT02QwK1EMBBqwZWpfGhn2AMNdk+A7FAx0V3KUsm42588j87THwybwEsFA8JPoc5e9MYqC1xc8vpUIRPzRAwuulvdLLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csxxnR/bWcbUB74lys09IHo53uexc0mnepHLsVzZUt0=;
 b=CEnfDRkvdNMyP1Y64Z7Us2+keW97fTcIKUNNCXEMwDBLiU5j6XsN1RjM9z9LXYltsfJ+CeuZPkWgAQ7J4q5nq94Bk0DoWj/9R1od60qiWl0Fx1Zs3nwUB6XaSkiJkssXfhltoI1watiIhP5byLm2gnuznnkvKRXTmAodiHT15XE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Tue, 2 Sep
 2025 13:37:18 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:37:17 +0000
Date: Tue, 2 Sep 2025 09:37:13 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 13/20] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20250902133712.GB18483@yaz-khff2.amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-13-865768a2eef8@amd.com>
 <20250902111052.GDaLbQvA2A0b8Ii26k@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902111052.GDaLbQvA2A0b8Ii26k@fat_crate.local>
X-ClientProxiedBy: BN0PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:408:ed::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1aca9a-987d-440b-7b18-08ddea25d5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eOWihuEeKMGmPOfUOF6miM/jbYTIqZfLnnGg1zOwlaFwlHeHEqgiSQepgMUJ?=
 =?us-ascii?Q?Gylv0ds+K9cFJ+QThE+NJiH7ACrpoLYVb43fX0AgdAeZ/eFBXjQPrJXX37XW?=
 =?us-ascii?Q?AtB+oc4cLD5hRZDvipZyPkSfXT0LwFepa0sK8u2DvyyCVmVzDbrcZbvCxSCK?=
 =?us-ascii?Q?FTP9I+PH2e65VyLQbUvJmOq3VuaDf1//hrdg9+VpNa/jRIjERY58th+hJAJW?=
 =?us-ascii?Q?fEQAPZulWRthotzMmEDjvjLhpcPw+8J2+ZVgNg3mLHfKA4asOgpXSjXGJcpn?=
 =?us-ascii?Q?Le1U57fqL4YTovTAyhCYHMsuw3+38hDLwp/kz+mQ/Id/W2pFO91iZoopdl9y?=
 =?us-ascii?Q?BivWCTt4ufdmaTQEAORZJnOBfhfS2fU9nS3YeO+wDTwEVqrJeDQrHs+ES7d4?=
 =?us-ascii?Q?QUuJnTIh1hQr8nSxZjwNctHOrY8Y5WMnk1IuEL19PnAFm0mYkz6sMHyKNm09?=
 =?us-ascii?Q?E/uMtiLAk2faAU89GPiRzDeaFT9OcmfzADaiEPnl9mhDgoXJpD2onqibqW1Y?=
 =?us-ascii?Q?uaQskbdelINwaWmcwoGQqpP/72aCCeqxoIPK9KaSRkkcpxOKLe10wMOXcK7k?=
 =?us-ascii?Q?wjiP2mpYP2iGefpKdRHz91JivcypLbB7VNHoxvGbHRQUksfI8xhH4OnJHV+o?=
 =?us-ascii?Q?Rdm5jVZ16ReJ7K6VVNdLGgH+M6iK5+iaPfvMy4NSe7HOXjHHtH5aEwGt1Qiu?=
 =?us-ascii?Q?2m6VA/e344VxUDf0fnR8DT6G4dpi5p0OhnSxb2jMZ/frJcB2kCzyJyrN74ne?=
 =?us-ascii?Q?fG31/2+In9ArvwLJONsjlQalXjoiIfHmpYaKn3JdnQWuePn/B5T6VxXSkm+9?=
 =?us-ascii?Q?gSX3kWxWNpX/bwGzDHAF6MhyztAChAzX+d1GEwgwzfqF8pEBGFb22GR9DlzD?=
 =?us-ascii?Q?KFJ5UlC8gmiRbBb6G6HuYnrqLypxEPawPMQwfTjNowTnDDzps9PyvBnTCEh8?=
 =?us-ascii?Q?nNU0XKDjjxgiGimijt4YFk+MiqFj2IMMf0gC9qEhf7xwn4d3nN+4cDlW06il?=
 =?us-ascii?Q?469+MiBpP2ZeGSRoBfjd+iq19Hc8llkGjI2Im58o8D4Lryv1MwWKV3KGVUTg?=
 =?us-ascii?Q?VQWROYIlhjdgIZoB/vRdaxatb0DujXmTvVrSr+fmsljkBi/9+iiRnDdwL8sO?=
 =?us-ascii?Q?/OYlj/4GVB7pjJDJ9m2w7XzJpSn8O1VmsVmumBu+uFrdKZzo8d4ZoYvIknUq?=
 =?us-ascii?Q?0xY8Hd7FeGMQW/5GKqOz9PiuNlA9L97d+DMycOcxxfMqydAK9fUTjWaB1Q4x?=
 =?us-ascii?Q?b+YN/9u6FbVy2xxXQHSbBqTRhVCBK3JVuh5ShpwMyH9K2e8rZHgCGfi1zGR0?=
 =?us-ascii?Q?fvEjGTt845KkTc7oPljCDv6thW/PDO+MMJeBLWx9u10cX05rBORRNXRcuq3w?=
 =?us-ascii?Q?16TDHMHsew/VpWwRmFUBOIlzlWTyBF9IbV9elA4SKVnVBJWLdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fz76JfI8Wy3UhKrimfPrWJM0KQDmvRe2vqLt07qDpj37K+nPJOp3G92ktW9R?=
 =?us-ascii?Q?Ok2OC07Bwav1wWgSmODW8dI2KTEEpJfjdbZj4ywi91QC9BaVQ6J1uBOrEZNN?=
 =?us-ascii?Q?bNt2o5deLTr+5IqrZYPm+hzB75sNOicbkTO0++Y8pZrjtEOgHLFI3KAs/Rln?=
 =?us-ascii?Q?PIiVjtIb8KIwTH9tihRSpU2NcQSPfM+KspbWcBuiD3d/AQdO4CPXDkCfOQTh?=
 =?us-ascii?Q?8qELbFkyxIBGrfbvaRzPI8DmTXDA1bajr3POAO0pTdSH8wVGqXqIQRbSbMRi?=
 =?us-ascii?Q?fy/w7vHG3oAjl1RrQSwmaZ0N7RanhiCnIYTucvvm6FYrP89ljBMWD6OdEbCc?=
 =?us-ascii?Q?aqe9q8d1MFigGdk+wTOf6IZLEr2hB2L9yoyhPkT3Rfl2HP0HPCmhlcrqHfaL?=
 =?us-ascii?Q?pE0vjGRbTZ0qK/SG7RyDB+tMSs2iBU8O7FlFGLE+Oe/JIvhEMX68liR97KbZ?=
 =?us-ascii?Q?gS2O7ZQsx0alCTuOrIUzKpf+uldCilZ2nVETVg34UP3SSnTNoSFKBl69S+dO?=
 =?us-ascii?Q?QqfJxHLvaUSqkMt75rbjGP6ubfiSfpZyDx8tGEjYG62tCeyTA0VgA6MEBgcg?=
 =?us-ascii?Q?rwhoEUhu9L0gIOI0R4LeFEJsJ7X9YTPn67s4+RhIg4Ri1Opayfn2MsnBwb8L?=
 =?us-ascii?Q?NEE4pBW20yEPYeUZ3kxTvm/HOo2hjvKvTxTsllvm7aheoe/PEPol6/tWw22I?=
 =?us-ascii?Q?FU4NSiFrQseyp3aQGUWVIeeZNodgq+qWV326nF4KG1wDSTCYg+8k6T/RWZqw?=
 =?us-ascii?Q?atGCW917/zlESe/oM3cC5QEA9aLj+5b4B8F6H937lO4fYtyzLCGZv2mZkeJH?=
 =?us-ascii?Q?W7c5QynRwlg4kx0gODMmCb9XvG5kc3RIWCNDRO6woLbLThna0YA1SY5bk4AS?=
 =?us-ascii?Q?bJBDpTG28mg2SP6L5urXIaOEWItucjzNff3ZqOw2jaGc03TygfUJGUUwxuZf?=
 =?us-ascii?Q?BihRY1zowGb9DTfMmRsxYqCNyDLg1nOhOAKS5/JOJOIRUqJtCFfs3derQQgo?=
 =?us-ascii?Q?GD8rhf6JxSk+zhGR4qR8vSNcKiQeqYny2IYqfeJ9w0vLgAzhmlkUnIy2HYUM?=
 =?us-ascii?Q?AMjjbT9sF9EEJ/jRqC4il1V8iPjo3Mkpws39EFz6GQPqV6njt85PUce9f4rT?=
 =?us-ascii?Q?HJh2hyOhxB33S8hqKT3fnD+CzzoxciBjTDKO7ZQ8UiraqnPr4TMuqMEDxBWH?=
 =?us-ascii?Q?LICi7DNty3TiPzBN2wChPEgeo4HZOzJvI/IgWimVNg2mnOE4vIE2kGqqRNWI?=
 =?us-ascii?Q?pbbwAmB2L5M9VnIJw3PiwfJNQ3Q21xbv/lvsn0+EIp6N7d8pXrKuZstoFYYG?=
 =?us-ascii?Q?lpU8VzRPmyZ+x5Vtv2q32jWT1mNYeYjKKxPfxQh7zwFPQoGNt6XVd74jhn1U?=
 =?us-ascii?Q?VEbR1aMWxBBOm0GSeptw1DdWMxbd2BIzud86GpaSAX+Nap+deHGAcOpiUTU2?=
 =?us-ascii?Q?xjc7/T+spQIEABv7exMdGisuxWkRggYpWurNWcso/VIMeU4aPXV5tq5HhJ/8?=
 =?us-ascii?Q?xeerDRV74YNnKY+eQ7/VZiAy6T+ufLej6ZS++b2J5W8C/Es1rr5GZJvGn3et?=
 =?us-ascii?Q?4i/6ToBvpLH50r3fAHQ+W0A8SrcopgE+LTkqP7Q8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1aca9a-987d-440b-7b18-08ddea25d5ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:37:17.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnvtJbgtW1dSKPB2dv7flgnrjVAs8mhhu+z8QlT/XThoMkeyXhWAVeUUz2KKnwBuI5JvcRVFgHsMw7+1O5wWIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333

On Tue, Sep 02, 2025 at 01:10:52PM +0200, Borislav Petkov wrote:
> On Mon, Aug 25, 2025 at 05:33:10PM +0000, Yazen Ghannam wrote:
> > +/*
> > + * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
> > + * goes off when error_count reaches threshold_limit.
> > + */
> > +static void amd_threshold_interrupt(void)
> > +{
> > +	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
> >  }
> 
> So the thresholding interrupt will fire.
> 
> It'll call machine_check_poll().
> 
> That thing will do something and eventually call back into amd.c again:
> 
>                 if (mce_flags.amd_threshold)
>                         amd_reset_thr_limit(i);

This resets only a bank with a valid error.

Also, it resets the limit *before* clearing MCi_STATUS which should be
the last step.

> 
> Why the back'n'forth?
> 
> Why not:
> 
> static void amd_threshold_interrupt(void)
> {
> 	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
> 	amd_reset_thr_limit();

This means we'd need to do another loop through the banks. Their
MCi_STATUS registers would be cleared. So they could log another error
before the limit is reset.

Overall, the goal is to loop through the banks one time and log/reset
banks as we go through them.

Thanks,
Yazen


