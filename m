Return-Path: <linux-edac+bounces-3161-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5FA3C4C9
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 17:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180881896E40
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217F1FDE26;
	Wed, 19 Feb 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEJ0ScxJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44031FDE0E;
	Wed, 19 Feb 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981982; cv=fail; b=r0qEQ8atEQQ0YIzJ7x74njp2c+XJd6aQKJLskQuvtasUzn92wlShV064919LKVyQRFu29oFEcuipkfGFolpKqjXQKzLrK6YkPzdHAAdUDRrnES2KdvXgly4T8CXJ7Ky7bqj8aIhHzfIZ+tZ5MWP8Tkh95FyAwD9W4F0+5h8d5t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981982; c=relaxed/simple;
	bh=L94gtMjxLFolPX2INljIOqRYKS5OCRU5azHQNS3atJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sGTXwtP9BHJL2XWedKRV7QwT1Q0QUQ8Ds9URZIYPO/diptywFC/hlZVeHTSFJ7vpLJlhTGUNYATr6qp4LfpxV3MveJfd980n9aQb/46I/+2Ca0d0dYW4NIHbVmhiaWubxe3jowpXJhVsNkj56xcUA+yxptnGRyrQindVUlkCnRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UEJ0ScxJ; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvnstxLKIPb5ghNmFgBy3ZbBYYIA3zeGk8pd4pxxdBiuE+WbG2e2yHAJWdu43TfYhPLbk6iMiUe8mTBBC9FDRvRBt5pJV7H5R2UrZwh2ItSw/mhU9j3Ql/IfE+3Wl7OKIrUIJ2xuK6djyAWdh7PaD+z3OO3/JI/zlqt4eXCafVmPh5edyfWCV+i3bbLM/Txhmb91vMcYRrm8Ss+/M3DbAE9iaRK5XhCFGgh/sdU6pK/0FZ+Yae0na8OF9az/zrqEP+aN0uVKAuw8CSbCC2IqPVhsb008VkXggV3ZBocLgqnY7zLltP646P91m8nv2Isb39kGrll60m12RmG5YVk+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O5gzM6SBtbJE02k8f3lbb7XwqgL2qfrnD5Q4ZLgir0=;
 b=mvj0+C/j+XEEjR0r+9h7sweHIKnYHBmbn0P3qY7o1h6Gz8bLe/UJVonMM+LxXEh453cQX2vGg5r2c1pg/wySU/XT5kGsyYundxnwdR4e91FdPGZxmPbHmX4lLPZ6H4gULd5t5MeFsAv5wbzk5qCAD5QDgOVjYajcMOeyEIyVjkqk5Vqh3NZmeLqFvNKI62scCxj2CtkP+vVPFAY8SjxN+YanXRt8i0Om3bXKkM07QTsDWEN3q/1XdDtW773sW0P97pBq2L5nsEgPwy0zUYUtJ1DuDOaQTP2nCbkhIjddrFyi4VVUQORBzhvQJtmo4Rb8zgKNEwWAS2hRbEVdyA/zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O5gzM6SBtbJE02k8f3lbb7XwqgL2qfrnD5Q4ZLgir0=;
 b=UEJ0ScxJeMK/qHaoI6koTkzg/Z8GnvWUHJv8VDC/WlF8wNbtYiX0rUMHCLUJd9w+LakEZO4+jAEFzUutOJ6WLKlVpSj47j39eyYLx0XAeom+NnH3Iu12B46+YefsCViDJydlz5+ho1SvIYFss0dsrmOxmLcVQc8NMjlgdB8oHqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Wed, 19 Feb 2025 16:19:38 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:19:38 +0000
Date: Wed, 19 Feb 2025 11:19:34 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 15/16] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Message-ID: <20250219161934.GH337534@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-15-3636547fe05f@amd.com>
 <CY8PR11MB713471B0264788235FA9079389FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB713471B0264788235FA9079389FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: LV3P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::24) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 31704148-166a-4f0b-9f04-08dd5101351b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0sr45IkGCRFfCoszbB5sTO0/afpv4AmQt8qtsoJ3YovI8mVVgb7wQ0VgRVC?=
 =?us-ascii?Q?qRoXNJhHlDajwbsCiuIdmamCzDF9dWK5IQC8ZQMywHLPpf3AEluneJpQ0ndB?=
 =?us-ascii?Q?3unIPUUv4QmhTR4/RmuK1sK1gOObF1LGCKRkJbLm3xvI/47+c5xvS35LtcPz?=
 =?us-ascii?Q?YKkTsSn4MZV4GATw2rRcsDZcpPefd60nXVGTy2rmUdCDRbYk5+H4T0PebLcB?=
 =?us-ascii?Q?mvxhKvKprOLDFYYZay/bxy2dIKG0FUl28/afzA46gfU2jnPUZ8HQWHIT/Cp8?=
 =?us-ascii?Q?e7tUXCSLszGBVA1Fo93OPJCn6JI9iPCNO5522zTArxg9cXnSybfltprJ4b2j?=
 =?us-ascii?Q?MNnw1v00gfZ4o5Txdu9YoyLufAINRVVAfNHxhSGPQwJYlzEaC/+lE3PijE8p?=
 =?us-ascii?Q?aTXxUTWLojBOXzEDtG9VsSTAbpaOuJCHj863b2c7emw+xBE/lV0jk0IWefKR?=
 =?us-ascii?Q?V1mvYnUq/WwquY5BB1+G3jXjwzntpdO0PZVjLRedhDzxvQ/0GtUHOjOTjGjB?=
 =?us-ascii?Q?UBIF0LBF65zy1NeHpQBfTDpTbW6lh8MiGprcS7xPF8xj6ZDUkZbuiPOM8f+S?=
 =?us-ascii?Q?KDfwi5zv2fODrB8iDJ/bzAedD3H4n4WkiCpS4k+HixgTtmf1pc1wTIhxN2Pl?=
 =?us-ascii?Q?20pi+dbGrd3vTQYAQg8s+Kg2pueZTYJV6UdZllwIoUnAwiF8PodKd7LLY9P/?=
 =?us-ascii?Q?bofIxpzGwg/wfsMzyg+gbVYazTF1rwgUFxloyIFRk/nMX4Ql65EWtlzYR7YO?=
 =?us-ascii?Q?N6elxe4BKEOzEenNmL6YsYTfQzRWKJWLL5EUBCY3n1+eM1GkObEQ8nrIRIeQ?=
 =?us-ascii?Q?IJuD3ZlhAh7577iLdTXCRBk0V0LY010FrnvWk6Ana9JlzBxnG+w6XWvNqmh0?=
 =?us-ascii?Q?HCMB7NM9NQC1Y8nwdiflmHogE8R8e65eZLeZ2hMymqpLuOdLRkEERe3+pKz0?=
 =?us-ascii?Q?no/kD7zrNmap+AelMyQhHVyWhxOcuv2Px1iUCDepcXQnVYR55a8YujRNZCx1?=
 =?us-ascii?Q?4Miv/C77TPeqFysQIqHEwgUfkDXpRebyyHKifmT11g84oH05eo6w4SFfWRNu?=
 =?us-ascii?Q?bQGvjTIu1PwfGU8fNwkfqryJ+1vs+RS+agq7dQsb/itlAGEE0C7E6v/TBwfR?=
 =?us-ascii?Q?Au+z18ZD5tSbfgzEG14J2H53TkmVDLAVm1dRvqnB2/gQe1FDa5i7NMoK+eBu?=
 =?us-ascii?Q?dUhqt4HRYTLiNnkxml9JgL59Fxz2EJb9qnE0QZIA7QDYqnlUbRlKtExTJpUo?=
 =?us-ascii?Q?t9vrx7XL6litqCZcPZPuJHrJS8JKuqbEEYxlMNjI6nKF0Z9NCfvhGzk30UxY?=
 =?us-ascii?Q?EtCPpVlLFEGoSKxQrYFgHo75bT5yZo2InJUIvQeTLdmVkzrVpxaJwsSdxiC/?=
 =?us-ascii?Q?EAQzZf72Jsx4XbySKg62TElqbKBS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2FMX2erOyzHmjlKTb2e4dqMTdoDhjxZxcMm32OdH6PD8twXoZxjZvc06SAq?=
 =?us-ascii?Q?1kDEU78uTgYH5x1rVEdew5M0fomcF270Uy/KvALTob+cqBnI/jO2kx646R9u?=
 =?us-ascii?Q?4WGNxqxgqzj83YW1G3WVA+iovgxI9H6RDPE2RtBIt6p1+N42LaJHmVgLZp80?=
 =?us-ascii?Q?boOtqL5ImoCTPhdwyvmbkL6QKCJrgHILJMNQT+zKS1REuJLaq+iEHqQMgc1J?=
 =?us-ascii?Q?N9kND4qh84B7hP4KWGcz1KUCD7eeL8O21REt/5TXubWXgnd+oBSELI4N/VdX?=
 =?us-ascii?Q?lfdJ0EZxA4A4kx25Kea8KGEhBQHYnSrZCV+StqHZd+b7axxF/rSeQkMh+3xq?=
 =?us-ascii?Q?sPqwzdlnwq5t6gcgvPkofGaASm8pWG9ryl7ns62XrwYKbN8b011rGrvZW/qM?=
 =?us-ascii?Q?ldYIApXCjyXQswVL3PZrsIyfEEaKDYhgQluZs5ejeGtyZ4Wp4HDFYksZtsUx?=
 =?us-ascii?Q?GSeHq9IVIb1gOZelrjy+eDjJ22L1IY8k25tllwqiUZLvDOVUqSU6Fi+waVHN?=
 =?us-ascii?Q?2F4MG7YRty+0ZrAud9Lz9UiaxHzn1yPXVf6pgYYXOlFRBe9RdDzAqwpvjAqe?=
 =?us-ascii?Q?AC4xRqKXRMVXHK4gvG+8KR22ODmubDu4E4ZutBzXibCJ7WeugrX67XFcLPFM?=
 =?us-ascii?Q?SSuQUjzVBjFYWW+z+2Obshrg0e2JOC1K8Mule6xWGaiYSxBLpGsuhER8hV18?=
 =?us-ascii?Q?eoxIJkQqnHkdAr/OS+/Bf6rToU6g4F8yovDjKoUl26L9qyMNBpYoiK3M1GUc?=
 =?us-ascii?Q?6golHk/i4K75m6CSCmA1coN4UY1h5p2egq2r4p5JkT7u3gRsf5wTnaY5YopP?=
 =?us-ascii?Q?NgxWotrEBgGSCJhb+IL7b52RpOapEoAIeosdhw2xSfj6gGn4PumFTbuSlx9W?=
 =?us-ascii?Q?hU9ZfujcRBuwHNdDrZQSE1x73YkIMOm/zA0ZWeDu/p93Bqu94WtledLb2EFt?=
 =?us-ascii?Q?1sX/Lh6I5asIVEloR5PmapFJnaP4hL4VCIVz+5hGBfATACz0K6YV2Tcd0O83?=
 =?us-ascii?Q?Tje5wwqj0VQrf7Vg6izw0tDAP9XRQOozjj+GCkkrSV0VLijbwyqj02iYriIN?=
 =?us-ascii?Q?0jRj07L8PEAVWKjzRkBUclbI+A5sXrfuQi6d/da6RINj/b/lcorrenHMWj7b?=
 =?us-ascii?Q?YOLqZnvuWgJWI6HAvZdwnSjJxdaZrW9CunT4GuJOrG/sxiO0iHqKUR07gA3t?=
 =?us-ascii?Q?6pmQVAu0DnoNecSi48/r4WH2yfPgLrFryux8gbYs0isDZw+My1DmmmxOkgoN?=
 =?us-ascii?Q?4iaMI7rLfqQwN/bUw5vkijMHL9cKDHmhtreDzFx54zKx0Z3jQE8vTFd4uzGN?=
 =?us-ascii?Q?1+15kbIie0121hBay1IHBNZ4otTfTQQUnYfXSTRJGGqmuS27vVsvx0hWtPOR?=
 =?us-ascii?Q?mHSLw53FEdQN5dkhOSQpZYyy4tT0loefS/zfbb7UUghohFseiiMhQ9oJLm54?=
 =?us-ascii?Q?nad3cCDWclmYNY/WL6IQ4MyTkup5qZW/Han9erDGmb4V5pw941xOU1U4BPMJ?=
 =?us-ascii?Q?ESsD/ueVvvbICYswW1GorD3goq77BEvFamaIBbbJaNt5XRpsd7hWwksAaNYG?=
 =?us-ascii?Q?StKRHv1fwzJ3+OoXGJ9EzcnyM5neLGDeDOQEmq9x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31704148-166a-4f0b-9f04-08dd5101351b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:19:38.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1LJvPjfnxrFpQrHb8co9VPcZv6Od64ooQAidg6ZL9GU8QDRU9ijmVWocpVsWsq02harQnuigarg6AkfJqPb1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

On Tue, Feb 18, 2025 at 01:27:04PM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -306,6 +306,11 @@ static void smca_configure(unsigned int bank,
> > unsigned int cpu)
> >  			high |= BIT(5);
> >  		}
> > 
> 
> Do you think it would be better to have some comments on the thresholding 
> interrupt here (as the bits 10/8 look like magic numbers), similar to the 
> comments above for the deferred interrupt?
> 
> > +		if ((low & BIT(10)) && data->thr_intr_en) {
> > +			__set_bit(bank, data->thr_intr_banks);
> > +			high |= BIT(8);
> > +		}
> > +
> > [...]

Yes, I'd like to convert these to defines. I left that idea, for now, to
simplify the changes.

Thanks,
Yazen

