Return-Path: <linux-edac+bounces-3221-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43583A48957
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 20:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5713B26C7
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 19:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E6C26F466;
	Thu, 27 Feb 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="llRe5nIs"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F726B2C7;
	Thu, 27 Feb 2025 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686385; cv=fail; b=gqDEmv5GkP2l6w7wahB5klwNn34+O6cLAK7PnKEzvQg3oinwFmVHTFf3CEI/mT8psqkfIpHX3fA1hdRX9dSJsyB+dggz4Do6DacMvJDVWjIoMnWpjOJNTGRq7DbNd8RId8z64mhh423w/fE0IrPFQO4JOsL8d4k9ZuXD3np0f6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686385; c=relaxed/simple;
	bh=RW7uL08R0UuDpX5QXxEKbZnIEOzQ73MaVJDthV5H8iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C4FAGL3mx2Y0ti2MciTC3Iris6lGgACDCQMKGTnKINkcC7hz3lD1Vm+1yiz4KYglw9P+Y9C1VLC1hNTQsKnF2Kn/eyHRjwkpTm6g3qXhJxYy6fi6M8JYjd5MJGDY3yQkCRBkXcwWMjwwTehG1B+Qcy0B26OIl1FHnyp5xVZ/18s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=llRe5nIs; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsGKQKTa/wCW2ySBEmQ+eOg9LywlEWEMkWMpPVEMv00+Dg+qIY6ezl4LycsHSwkX86oHQ7Q8KSHmA7Y62sfFlz9jp99jTcTO1bu8WJ2w2pT52bgaCxMUx20AQnVjDjh/j6oItk0H0M1irRQQlXw0CyYRW+3aKruSLZ1WWifd24cJcUgGtEsPHz/FcuYoMnpc5ViGLEI/GO8I5H2+SfrB2y4FpVe6Ue3QkFzhrkghFTki/UZQJ+qj9hP/rpcaZ8pk7eAb8awCG6k/MxNBomh+RZV1+KwuRfnQISawmxMY54PPYPP1Q29cZtfh0KXxqsUdv37/kMqDLWOt10B2C0tceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnC3+MWJjjHkPv6yKk/4CwGLj59/7Ut/bRB7xojtwEk=;
 b=K0TkgMTWumkn7u3PaBv86HwdpDQ2ApmqH1pVV+JZqIfvafoIbuuJxnHf/JfRf0mSLflOFkVECcmvdNEcwX7RSs7MkXLjQZc2bzovc4ZyYBy+N6qvtILKifoQCjeqGKUcV27+RU52WoCcjEHY3J+bA8dUi2iHvnrtzFeySJrk1++gQsNeE0B08MSYhAWgy3YqiEFKk4PVxEuJjcjvKEcIafrJ1dyLLdeLIJ+3k7dslEn8rKCIxAdzldPUIZ0h7dFcr3KK28fUIGxzNgTJuGGC3VIMHt3BBdeIsQDWSmZhNyms4bktq537zL312bulNM214C9j2kELnpGl9CaNsLPDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnC3+MWJjjHkPv6yKk/4CwGLj59/7Ut/bRB7xojtwEk=;
 b=llRe5nIs5V1DqOuZXxfZeL0JTqos1msFsGZQkLRl+vQbSLN7F99QGBuJOyp4/XuKMhVQaSfr669JA/DP1gwpPHKb26s/jJUETkN54erQENLrlYqGyRdWkQOT/0Q176/o9AsNvs0Su8dRId6HK6jtoxwQoYjbhTo5GqhEOvZmrlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.21; Thu, 27 Feb 2025 19:59:41 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 19:59:41 +0000
Date: Thu, 27 Feb 2025 14:59:33 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
Message-ID: <20250227195933.GA936031@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com>
 <20250227152500.GAZ8CDzEBRWBUukmcl@fat_crate.local>
 <20250227163148.GA785742@yaz-khff2.amd.com>
 <DE184F9D-EF80-4A88-9275-C900C4AA13D2@alien8.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE184F9D-EF80-4A88-9275-C900C4AA13D2@alien8.de>
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 920e530f-0388-4ddd-42be-08dd576945bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PYiwkxXhi1iii30YKMXwZ77p2xkB1vbn/i3FCEdZUmKdbfpqv3B3OTcGIOuL?=
 =?us-ascii?Q?mVpsq3ZYRsvbEJniZj515itjElHVpccuzjwNebMTgzOGHKXagTuP50TwJ+Cg?=
 =?us-ascii?Q?ck+fXsuswGCQ4AwqXeRBFmfSLUmfRQzTqt+aQ06kRiUZzJOdLUd6xfqYJYii?=
 =?us-ascii?Q?FM2WFht2IeG0/1lk5aPmq8G+NhTRWFZYuP50mrnpiPak4LJSRP/9eZ1WjfvP?=
 =?us-ascii?Q?rCAOYoyqq8/+rru51FwzpLzLA1i18mhZh0qy8srIQMRs9mp9Kus54OWOOd7p?=
 =?us-ascii?Q?8O7OVIcFIB82EaoEnOOlfEA1VifmLszEP2o/NznpBytKqRjOHFyUK/ZTT952?=
 =?us-ascii?Q?Rn8CzaRoESA+M5f1RtJvDFZsSWDJcI3xL/Q9pso86FW1KgY22GyhD9TmQ6ke?=
 =?us-ascii?Q?9+5MJl/Tx+t/QOuOktum3l0UVZJfJSNpxksVJ58uk4zZ1xRnYLUwrXpq7lQs?=
 =?us-ascii?Q?h5C3dVOTR+Vk8HKmPNnVuofRooHM41PfLSmHcOzCB109rRuzOR3UZgGCfMsf?=
 =?us-ascii?Q?I417fkZwyaPqu5MKZNmWfa8iLD43SFTvF+2ABaMJJfKJCtUccqvRhf/Wa8q/?=
 =?us-ascii?Q?DVGmSm8qJrhlkNzNwDOEgp2PWsEu8Uk9OFrwcS+pbOcSTInZRCO4NBnJS2oj?=
 =?us-ascii?Q?gqkDjlyM+5pPS/FlXA8d1K83GRqhyNgc4jK1fQH6U0KXWmC+BBeQBKm1dRS3?=
 =?us-ascii?Q?QZ1Vssy0/EDL8CK3H3yG4knCX/FDeDoEeC0pj4gsEEUt6B01w/jau5OyJ0s3?=
 =?us-ascii?Q?yL6rahxjCF2DK7o99KWITFdh6jxZPhtwRZuPzpuji5F0DCwXkQKvBF15nkVV?=
 =?us-ascii?Q?1f3/YEOzsHFes24Q+6Ep8CpKVrqiG81/Z5oG7D1aEj/RGAij739TIioR4tLo?=
 =?us-ascii?Q?pb/0hLEdjvJTEORaAQNv8pJRtxatdqT2PFLPYI0bnTsTn4wICQ5n8mknLqpc?=
 =?us-ascii?Q?BSKQAbL5Qcuw7uDh+Xg4svQyBinKCnnuejs3Z2fy9Yz3mGl9GxoX/PhxFy8b?=
 =?us-ascii?Q?vfe35qBEvPNbIYzm2+iCTzSbgdVCU7nFb52KBiIh8e97ombbjgal3cFqsDbW?=
 =?us-ascii?Q?Uq+Q130MxB1V5Su4nVz9A6eVgUTSEn8ExzQ38EKmQLWlwT+mbdPySALU1LI3?=
 =?us-ascii?Q?b5zC8C1NuOP5U4lg6C1oAEtzsOeO11f8qPdlovT9c7Zvc+S/GGZ06VC9/Z8U?=
 =?us-ascii?Q?5NjRNfrdCK3pN9P9FO4w99RwU7gKmiwGfnalfjT2y+9tNBnU/tHvFtJYDMMf?=
 =?us-ascii?Q?BL+05N7pA3/oxuiqdbwvivybTEu3yIfXuYWurnA7AFwQEdlB9FlTyvFwAp3C?=
 =?us-ascii?Q?JaeUVg+Sa10xjyA6AMo+6nkNObR3oQc7xscuOZxIZbMRmy9gqJPpB2+EdMsg?=
 =?us-ascii?Q?fLv3asIBjocD+mShUT9XYLp7nuhEZ+FKN8D1NR6eMn5QaAzr3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZtWgEiuVyLMyVi8oXPGBcFYCsJdiFgS8AQL3o6FMnBp8IfpqaFCEQwa8vKt?=
 =?us-ascii?Q?4A+FRQagONuzl15gVBwAhF9Mp1FDnruUGIfBPDElvgslHiOaGNtbAbSw8HiI?=
 =?us-ascii?Q?XlOwuT13iJkquNTJEgxszhi9oCaWge9Y8FSpNw6juRjmo8oNYyl1jfqtYy6V?=
 =?us-ascii?Q?Nt52qqOQJWHLQxDMRdtDR1wxTumzE6iVwHhQ2qn60cvVwMDV2oZS09+c638w?=
 =?us-ascii?Q?Mablv24mZjVkoKMpRReIFkW+iuRvfj2m6moN0LKwuCoeYJ091aL4Yd8BTaAs?=
 =?us-ascii?Q?+Q9oPyigAjHuBHVyiPw43OtPa5+KPuTLOk+etvBWQ+Mj7eCp0BZcg4U108Ip?=
 =?us-ascii?Q?NRsExoJdck0WrovjvDiar1/JQKuyiWJHmZc/2oAv2wEXEb8NKKuLGepEI90N?=
 =?us-ascii?Q?ASX/2ZcJI3q0RpAQLXQIssxegieTEQMKNAW5AyC7MpEuyMtzUI4T2xlyOtxp?=
 =?us-ascii?Q?NqJtp1BhU8la/YhcHg8Jmmfj111Radcu9LDVi9akVyTb1kXDPajlKXzGxUfK?=
 =?us-ascii?Q?kkTz9la/U5kiYhJPTU1Hur3i9Sl94jeVnLvdXGkUBeWvK6uOeK4WNy4kyFr9?=
 =?us-ascii?Q?Yk202CLL8vnd5ZoXzdyeso1Pv9vy87X83pjXRUP7DVKCyGYKDdQCgQKu59lf?=
 =?us-ascii?Q?1lOTEsjiB2c6WKEpHcn3UzxMWKKVbmWSW6UBuxNBcM8rnhsCFUCNn0vQXDQp?=
 =?us-ascii?Q?5/ayKvN+K0KyqOK3bd+ooJ3klQoY+ROR/ZI+OE1U1E78pIqXCKyJ//lSGxgj?=
 =?us-ascii?Q?3Sj+LkJcT5S4VdyO9fKFZNxtWvwdKLYNMRojplH8V+YFtGfExa55a+/Mtk8W?=
 =?us-ascii?Q?8oXhrSPlhHqg0CrHq/tTx5VpfhN3dThw5wOA81Z4luh62l2ZGiYrGEWhMB6B?=
 =?us-ascii?Q?hRw/rCs1O6rLiJfpqAhmnkp474s63fAz23UOx0ijePMkSfBRTaIiomfSQCPT?=
 =?us-ascii?Q?Co1AenOPdc3Dj+nNLrjIv0vrk+K0Dn4ykSuAPeaGBE8zpHVSldDlYWHEkqJb?=
 =?us-ascii?Q?HLF+TaMYLECB5VBW1ZgMMpF7w0VHWptjdGLUPx3QsZJTMkDJ2/6DA+FmI7Po?=
 =?us-ascii?Q?h+xiKZY+EoljfqgVwVKLua1cKWzcK5focTCDRFRNo3LIKGl7JM5pEaKrzRra?=
 =?us-ascii?Q?E9Fh+tNumKWsSALpPSO+XJy+EqtCeXGkP9t8xSoHEd1mdtdlxSF/i1dFUZcQ?=
 =?us-ascii?Q?kmKUPZ4ioR8Vg4QRYESTjmVh0H1T1c0Fi+TzhEKpEDYng+mCrnRXoowu6eAB?=
 =?us-ascii?Q?Qxz9uQWdvweUQAw3BL1HlMf1x3TD9STxwGbPkgERJz+dG2YhlL30yoHo3ZNZ?=
 =?us-ascii?Q?T595Yy5rIZOu2iCuirZPswJuUu3zZULp5T1Qwe6LGBjnZUkZBeM5Ycb/oONH?=
 =?us-ascii?Q?Hc1AHBOe78gIKZd5rC79bp+O0462UCcnRID8kYxUBonlcF8M8ZNl23I/m+2z?=
 =?us-ascii?Q?lhQ0btp2Hcfd4x/NwnNVbEsuQOKa/I9F0y10FhEVnUSDhRoCUQWDjn2H8J5K?=
 =?us-ascii?Q?QSJwJGV2Puo4XBGvehccesst+ch8jNKjPe6lhWMqS4DgwBALtAH1Q2PVXfih?=
 =?us-ascii?Q?XruAHYLCCKMcLRPdX61HL8JhMIWy2vJPqOIxpj1F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920e530f-0388-4ddd-42be-08dd576945bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 19:59:41.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6WHaWZZCAF93EIKnQEcUURlM2Gj/D1/qKzmZdWD0jZsI+xgQXKQHjpVHp2zlLgJ3TIWHe+cmYv3wZrj4d0Gng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194

On Thu, Feb 27, 2025 at 08:33:19PM +0100, Borislav Petkov wrote:
> On February 27, 2025 5:31:48 PM GMT+01:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >On Thu, Feb 27, 2025 at 04:25:00PM +0100, Borislav Petkov wrote:
> >> On Thu, Feb 13, 2025 at 04:45:55PM +0000, Yazen Ghannam wrote:
> >> > Also, move __mcheck_cpu_init_generic() after
> >> > __mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
> >> > MCA polling event.
> >> 
> >> The reason being?
> >> 
> >> Precaution?
> >> 
> >> It was this way since forever, why are you moving it now? Any particular
> >> reason?
> >> 
> >
> >1) To read/clear old errors before turning on MCA. The updated
> >__mcheck_cpu_init_prepare_banks() function does this for the MCi_CTL
> >registers. This patch does this for the MCG_CTL register too.
> >
> >2) To ensure that vendor-specific setup is finished beforehand also.
> 
> That doesn't answer my question. All of the above gets done even without shuffling the order...
> 
> 

MCA banks can start logging errors once MCG_CTL is set. The AMD docs say
"The operating system must initialize the MCA_CONFIG registers prior to
initialization of the MCA_CTL registers."

"The MCA_CTL registers must be initialized prior to enabling the error
reporting banks in MCG_CTL".

However, the Intel docs "Machine-Check Initialization Pseudocode" say
MCG_CTL first then MCi_CTL.

But both agree that CR4.MCE should be set last.

We have an old thread on the topic that led to this patch.
https://lore.kernel.org/all/YqJHwXkg3Ny9fI3s@yaz-fattaah/

And it seemed okay at the time.
https://lore.kernel.org/all/YrnTMmwl5TrHwT9J@zn.tnic/

I don't think anything much has changed since then, so I included the
old patch again in this set.

Thanks,
Yazen

