Return-Path: <linux-edac+bounces-5713-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIbWLpgqjmlsAQEAu9opvQ
	(envelope-from <linux-edac+bounces-5713-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 20:31:36 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674C130B72
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 20:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 862113066823
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 19:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605A4284880;
	Thu, 12 Feb 2026 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lFPFljpX"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CCDBA21;
	Thu, 12 Feb 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924670; cv=fail; b=VHyuO+tz8pinY2e4J9mkhAbyxm7Qb96HjzezuKWdpnSUCereK5Y1adnLR3g2H+xhGPIHuS+yywkqjqVhAnuYmzSYxU92zdS77RXsfdpRD8j98QiaF+5v3Q11DMZyYyUBaI8cFAjV7wMylmM8iep/ZIlkVvJ30xNgE5HrDf7rxhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924670; c=relaxed/simple;
	bh=ozevW4cMBwcW7a1sBBY3Hb49K5vfp7IsUm6C8zL1UJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJSV+8gVdvt+oW3nJ+TRfEggPovuZk9Pv8BNMiN0tIlpf9mTYWHr4SCYuLO4AfHJXZ4nRKzcWBiDhapOfW6zlAn+072+KJ+p4fyelvcAAlBKYrRTFeX2WsU36A7iIDVX5vxgaj4SAg8i6sadgqtqXDAxA7FUjxuskiY6/mse+VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lFPFljpX; arc=fail smtp.client-ip=40.107.208.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcoXTO205VAQIYI6gejnKfiHbU8047+ubDQlqKDJ1+Ys0yCvdGmNCJI0lamnqh3ktri15/Sq+IQXrHao9SvRhl5QGMo7jQKU4AXirDbrZrtfAT6yqbdfDaG5fYsFBkHFzHaSsmwAlqr+GPqGHXfu/mzEDzCAKk7GUZOE3qnqkT0VGZNiiI19trI60L0kHqbWAumnM9O9DzT+OzRjs3WVmrKZquc7otCncDRN3fiwOq4aPmHKVIE/FqlG7lUfNo+Qq2hmiFrggPi4Q7pB3YwqqbYwyws7Q55KXQyiCokWJX5snwLXm9Ns4ABRwLNOSLtHjTtQUAlH2EVkfcE4O68+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo6Q35IZo1k6TlrQ/BTA6yojPw0Pz1Z1ameKc/8FpxQ=;
 b=QlEpFm3tKdzC4ZZ/UDjSN2TXcfBRRsBvWMo+38TqnMkcz5j3WWLJtgt4aiAPcRy9XJU6v3s136yS7UzEOVHzzYRmQLzW6241FPNPThAbsbbZbab5dakwM16+4/G+J6TlN3RU1MiJSwt0uMlpLAsUWROs0QCxEBCfw5hU21ZR4LckpbukQs2vhypHCUwvY/CoX8RlQ3nS1ucZb5LwNFxSLR4qc2R04HDw8YgV6rzMctu2ikpf3IEuvWfFEZFl3b2ZhRxtzreKee+A7T3t4va9I2c15GcM8afG6R+/rEi4jzcyrnJjpc4Ks+KDmUFljisHpmr4Z1V3aYvb6P2mA6zclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo6Q35IZo1k6TlrQ/BTA6yojPw0Pz1Z1ameKc/8FpxQ=;
 b=lFPFljpX7okXpiAnsqBFyG1ca9mLmd0ditXQSMInXawHtZg+U9Ze3oNKLkZ4Hz+V9DavkPajyxeBu95Y2JObX4VrEWwav2TbF2SsCICXxrLqLiM6YsVQBjGwGy2YyQWdi9EZj9z61TrSEXlG/EYzLjbgx9sluUJh/0ZLVF5PVVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 19:31:05 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 19:31:04 +0000
Date: Thu, 12 Feb 2026 14:30:58 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: William Roche <william.roche@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>, bp@alien8.de,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	"Allen, John" <John.Allen@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] AMD VM crashing on deferred memory error injection
Message-ID: <20260212193058.GA315621@yaz-khff2.amd.com>
References: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
 <20260209210819.GA445331@yaz-khff2.amd.com>
 <20260209211843.GA459737@yaz-khff2.amd.com>
 <6f87d29b-c30a-47f8-a519-0e1fba36f1a7@oracle.com>
 <20260211163438.GA1637@yaz-khff2.amd.com>
 <09d2117b-02a2-4e16-8536-1d02e85ae6ee@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d2117b-02a2-4e16-8536-1d02e85ae6ee@oracle.com>
X-ClientProxiedBy: DM6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:5:174::20) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: c20ce3fe-a279-4193-8fb3-08de6a6d42be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2hTv/VdBUJ5bm2snQas7b7xZAUehhQrJ/jnWpVvC3HlSXn+dz02sIY6zPBJO?=
 =?us-ascii?Q?4F4+xqeFIaU5GrZH7Dki24xRTuo59DTGp+/talN5cFfDIfkKXlBXIAzXqnaX?=
 =?us-ascii?Q?FLmbxdbPTYFLpRVtNAnUIEzV3lZp4JgS/Z8nIxXhFi3Ln5pVNKEdPviYYyg6?=
 =?us-ascii?Q?S4us1ze7Vf6luHryBbeynC/ZLlz0KNXqEov4Aiowrqo2vYRUwKMQpRS3J3ka?=
 =?us-ascii?Q?O8yOOSZktFfnQDwooZPIrwwHIOxEq9ayyJOLC34hytdQZT74awBOsRnyRboc?=
 =?us-ascii?Q?n1yHhJy4lMOy9PPyre25E7553Ku28U7/7kCfQyznReC5j6AcKSPZS8PmVc+B?=
 =?us-ascii?Q?OTWefLoYcR1nxRFIJ2L0S4CN0kOuKz/mXFJU1NWrl1tK8XTrEMC2Y5gsm644?=
 =?us-ascii?Q?BRwb50ofOmsmKZj1K6V7lz6Wvz/7dluiFqwrs4kRyoiFc+WmYoykQkGmf1im?=
 =?us-ascii?Q?76rwy6KEKdHnvKk94zjxawAinG6NZUDZ+lAtOEuZQdLclBzjdzeZ1uGcAlHb?=
 =?us-ascii?Q?qRbFtuUGeXK7Zv1jPSQxdD4uaiBWj/j/V506JtcZ1JMknuBkZHR7duDKbAjx?=
 =?us-ascii?Q?KuUJ17F0U8poRymrL7mJLV3dz2vlGevK617Zcgf8NM2vfxaEQWXibaE2Fdy3?=
 =?us-ascii?Q?v1Qknud/U12lYP1z6eLZqbdMnJH5/GIttmozLwTukKJW3rNHDeXTV3IBaHLF?=
 =?us-ascii?Q?7io0HaSKWlAoHMxHKYLf/UQQSjOZwk3W0hJvBYiYygsJHp0p/bPpVx12vvaD?=
 =?us-ascii?Q?WnGAgCJjSLb54ww0gVvmd2S2YcOqjF2BGI+a18kyGKmB8pTh8aG74DFObBgg?=
 =?us-ascii?Q?JsROgy4A/uifQaKTybMxvWvcorZVQzOMx9IfreXv48x/a0Qr/3Ug41WYBBZF?=
 =?us-ascii?Q?YF2eDcjmncgje0vqnlKVVShUQBlABE22t3hZrBliCLZJ5kyKCPuotN1eYcG1?=
 =?us-ascii?Q?sQIgZO+aXN1SbKKrtVx4ztab1flZxzArMJuKjgpD7c8jindXXTajzK/hd0R4?=
 =?us-ascii?Q?QQ9JD2TjKTSOxzK3zhAgwAkCPxhBEPB8rmaRdCW3FD3Codp/fZu28wPwmnR0?=
 =?us-ascii?Q?sD/Bz78iRFEgyn1RrREgRX+FcJ2UYewzNmH8z5iVTTH+pvxdnCo5WQ6QVPFz?=
 =?us-ascii?Q?X3l/7MP/qLggVYmSZtqNaXzq7mPm3Ld3Es7Y71s3UHKmRUJH5/sFr7VTk1wx?=
 =?us-ascii?Q?cxQqSTwtVZ3bdaQb7ObcDqUOkMiN1PPG9juU6izxB0mhx46K/HL07Bh47xbV?=
 =?us-ascii?Q?P9Ly2lELT34ffRgsmcSEbcnVb7qAyfJG3CWAatKCZasbPTXPU4LqLl/yvZRD?=
 =?us-ascii?Q?whBukQTRHN+KfkqAJ2uwL8Tkaw1gkKubZF5Xm9wotqWXkuJe098M5RRfJ/UC?=
 =?us-ascii?Q?K77sL2KiIS+bzWYUFr2Sd8JS70JNzH3SIqZ9ubogOtL/ND/zi496/wIH17jz?=
 =?us-ascii?Q?lDWG9v7n4cbgkpAipWfkpGWbJW0p2WEDaTknKQ6pHlTdO7uF6qP3CC+rP+6z?=
 =?us-ascii?Q?0sNOc1p0ov88Y6o9b1vus6c6QDQx0bEkHQ0IbabVtx1tYmYVux0iLWZSJ+C+?=
 =?us-ascii?Q?6QvWq3qpkeFjqMydZRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0P2DOAfSYIcNTeMhy1LvF55b5bg5CJMnm0/2tUASdK6MaG3zPF2eRe3i1TB?=
 =?us-ascii?Q?1OI065GgoEzJKgfqZJ7tuOI0diy28zSkkxm4s7w0cuQr0jA+zTvOqoz2FXWP?=
 =?us-ascii?Q?yERF/9J1Aw6r5Iwil0c2PW1Eh6RYuRlj9jC1uWTPztu4Em1c/4dn4ixnGUJC?=
 =?us-ascii?Q?qeFhzsd4g0STJ3Ueruvx/yT13eTScyfqTJMjr3q2mTMzHnnr4t6de9Vbm2qP?=
 =?us-ascii?Q?8+wwK/OdPuaf5+FKG8wuvMaqcVeK25wYg4JHJx/GKAQz8UJHVO3zwTWlWzOp?=
 =?us-ascii?Q?1iB3Q7kTs+nuysuOdM7xjLWYX7JFyy07+A9BjUtYuXHX1QVRzZihfRxPlmdM?=
 =?us-ascii?Q?xYJ64Ghf7sam96Gh472hab67APppxX9HdmV+0P2trI0/VXKkMmuJq/Wh9FoY?=
 =?us-ascii?Q?7Y9At3Ikt2NBEaS9YfkC0sVmlmjvC0QX9IeLJvwa/5K3+yqBptVTjKz8m5v0?=
 =?us-ascii?Q?mGFWxOSgBjHTGe6AM/75FMWMP9GcRer0HSCxlDA7t03wojYv2KTSSDU065Nn?=
 =?us-ascii?Q?V1+bBNOGkBhGy/3YUDL48Xc1BpKNt1XWmiCWFbl1i/PY5+nYWAx+60o47wei?=
 =?us-ascii?Q?C1B/jh/ksa9lczti117PqOyVIzhev1jCZ5xYkKT16UvVy+rqSQTLqGx0jKFT?=
 =?us-ascii?Q?A5klH1ksCJZZ51wdR1Z5GPdfa4cPMSIZORdDLkhuaYHavbiGwz01QQ06Fk9d?=
 =?us-ascii?Q?GJMIVEZfffy4csE545Io7q0j+UCyquF3WwmaWxGgWE5sPloT9ENJd7lNWxgB?=
 =?us-ascii?Q?9BeFPMmaiEQBmLKYCa7hDYwneoG60Dd0U5X/9SGYOcib/rMDbWyK/lzHOMSw?=
 =?us-ascii?Q?1sYGMnqSdJSHbggyoM9dUiFQLDVq09Sxa2CdSMpdvXUJzxiV+HBDFctcErPf?=
 =?us-ascii?Q?kTZ1AXTaz8OI1XAH1e1k2A9kQ5VDI+YNLs+ZzH9Hz33puSoTv87UlrOAMok3?=
 =?us-ascii?Q?BqIycGbtVmd7jJAEYDXO7IRj1GOK/PpdqNpqHpvhgg23+PLn4onpsryDsOlg?=
 =?us-ascii?Q?H25RmT5BTdl/6wLVvR6MKITxctm+YFaZf3BlpvLpH/2R6ZdI8khC87ucQGp8?=
 =?us-ascii?Q?Nsw2gQeHPYpYPpf28vLOYuYX0Xuqgx8ZX1LiZwNBtToPXBZ6+NI7njAAQA2o?=
 =?us-ascii?Q?devp5+SVx9Nvh5Aq+P/i0RbWBv6n3ggJlQR631/BWHeQ0pmSeBKrNh2crEwx?=
 =?us-ascii?Q?n1jgZML4n85CzHQ15YGzufHqzlFDXIJO+JIPt/1jA2M6DueIqjYRp4rn278N?=
 =?us-ascii?Q?5nFBahDERmFE13bOnlNiEX/DViNxXTyPxClZs46Iv81ak64WaysUuBJc79J4?=
 =?us-ascii?Q?bPq2I/z49WGQhSIndNE1V8Hrtsz/ULrt5IGeYckBo8ITVSMHpabqvdFA6IJt?=
 =?us-ascii?Q?dbRKcVV2UGLzdBgRBdN8dYil4YoNq1wxzmN1U2s34ZFZrlOHVoB/77bVigb1?=
 =?us-ascii?Q?hFfivKlClx8BGcK5aJVmxVYiolTYqT4V0qiQYkQe969J2V67Xt+IPuXnGLuR?=
 =?us-ascii?Q?6LrvIFxMN24GwwbW/ckoVk9Sl407zy5/b7PcfW/fMoMGZqffQMSjwZntrPFT?=
 =?us-ascii?Q?/J3Ogrrc6W6ZJIxN8u5L4DZUx2u2CTINwu/Q8TdThcxqthn7GM7KDcS+/0AG?=
 =?us-ascii?Q?+PRonnuUvGTmOC3Y9WtHhujUI0JIoyJG8jIw4kSyeIrnCk626Dpb0ne67zqw?=
 =?us-ascii?Q?eRBRvoWmyX4Y0K9mhgl7LzNLGCExeGn9WU8TVhFIimcMAYhh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20ce3fe-a279-4193-8fb3-08de6a6d42be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 19:31:04.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9/qb93aIv/FTCrhM0oBc6Wrf045I2WK+YEzgT3RIwaEweTYiYjHpOKYAVErLTUZrFFvTlcUaP3Pmwa6TqWZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5713-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5674C130B72
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 04:36:47PM +0100, William Roche wrote:
> On 2/11/26 17:34, Yazen Ghannam wrote:
> > On Wed, Feb 11, 2026 at 02:42:07AM +0100, William Roche wrote:
> > > On 2/9/26 22:18, Yazen Ghannam wrote:
> > > > On Mon, Feb 09, 2026 at 04:08:19PM -0500, Yazen Ghannam wrote:
> > > > [...]
> > > > Linux:
> > > > arch/x86/kvm/x86.c : set_msr_mce()
> > > > 
> > > > Please note the comment:
> > > > "All CPUs allow writing 0 to MCi_STATUS MSRs to clear the MSR."
> > > > 
> > > > We should include the MCA_DESTAT register range here.
> > > > 
> > > > What do you think?
> > > 
> > > But before trying to update the set_msr_mce() function, I don't think
> > > that KVM keeps track of an MSR_AMD64_SMCA_MCx_DESTAT set of registers.
> > > I can see mce_banks (for ctl, status, addr and misc) and mci_ctl2_banks
> > > locations in struct kvm_vcpu_arch, but I don't see a location for SMCA
> > > banks like MCA_DESTAT MSRs.
> > > 
> > > So if we make kvm ignore this update instead of raising a #GP error,
> > > would it be a valid solution ?
> > > 
> > 
> > Yes, I think so. And the details depend on how much of the platform
> > needs to be emulated.
> > 
> > Some ideas in increasing order of complexity:
> > 
> > 1) Ignore this register write.
> > 
> > 2) Do a basic validity check.
> >     Allow "write 0 to MCA_DESTAT" and #GP for any other value.
> >     Don't need to save MCA_DESTAT values.
> > 
> > 3) Replicate the full platform behavior akin to MCi_STATUS.
> >     Would need to save MCA_DESTAT values and do a "HWCR" bit check.
> > 
> > I really don't think we want #3. This would useful for "register-based
> > error injection/simulation"r. But that use case wouldn't do much with the
> > MCA_DESTAT register without all the related Deferred error interrupt
> > infrastructure.
> > 
> > So I say the choice is between #1 and #2.
> 
> 
> Thinking more about the problem introduced by your commit, I realized
> that only SMCA systems have MCA_DESTAT registers. So we should not
> allow access to this register from a non SMCA machine.
>  And Qemu AMD VM is an example of a non SMCA machine !
> 

So the SMCA CPUID bit is not advertised in this model?

> So according to me, modifying the hypervisor kvm to allow the access
> to MCA_DESTAT is clearly not the right move.
> 
> We probably should implement an entire SMCA stack for Qemu, but this
> is another topic...
> For the moment, Borislav Petklov was right when he said that kvm works
> as advertised. The problem that your fix introduced is that is tries to
> access SMCA only registers on non SMCA machine.
> 
> Do you agree on this aspect ?
> 

Yes, I agree.

AMD systems generally have a Read-as-Zero/Writes-Ignored behavior when
accessing unimplemented MCA registers. But this requires the system to
recognize the register space.

In this case, the register space is totally unknown to the system, so it
responds with a #GP.

> If yes, than the correct change is to test if we are on an SMCA machine
> before accessing this register, like:
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 3f1dda355307..8664ba048a62 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -875,14 +875,18 @@ void amd_clear_bank(struct mce *m)
>  {
>         amd_reset_thr_limit(m->bank);
> 
> -       /* Clear MCA_DESTAT for all deferred errors even those logged in
> MCA_STATUS. */
> -       if (m->status & MCI_STATUS_DEFERRED)
> -               mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
> -
> -       /* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
> -       if (m->kflags & MCE_CHECK_DFR_REGS)
> -               return;
> +       if (mce_flags.smca) {
> +               /*
> +                * Clear MCA_DESTAT for all deferred errors even those
> +                * logged in MCA_STATUS.
> +                */
> +               if (m->status & MCI_STATUS_DEFERRED)
> +                       mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
> 
> +               /* Don't clear MCA_STATUS if MCA_DESTAT was used
> exclusively. */
> +               if (m->kflags & MCE_CHECK_DFR_REGS)
> +                       return;
> +       }
>         mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
>  }
> 
> 
> I haven't noticed any obvious other non SMCA limitation in the other
> changes of this series, but if you think about any other case, we can
> probably fix all of them together.
> 
> If you agree with this change I can submit it as a formal PATCH.
> 

I think this change is fair. It could be minimized further by adding the
SMCA check to the status bit check for the WRMSR step.

	if (mce_flags.smca && (m->status & MCI_STATUS_DEFERRED))
		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);

Thanks,
Yazen

