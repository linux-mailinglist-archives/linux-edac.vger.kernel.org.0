Return-Path: <linux-edac+bounces-2528-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3C9C74BF
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 15:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F170EB25077
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F61DF75C;
	Wed, 13 Nov 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KCDyIsX2"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C715A848;
	Wed, 13 Nov 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507975; cv=fail; b=ov1Nv/NBT6/R8+3vGr8v+SIHmzTffrUvdCEGzjedUQGR5aPVbtKPozfYGd0d8yLkpqEIu/t5p5spobz5Pv+Pvs7pqWZHSEKE/5312xe7GUZ85bNUN8v8GsdYX9dEGfQiooJVVmfJHazdEQ9ZNj8ug8fc/c3KnBWYAcybHSeTrPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507975; c=relaxed/simple;
	bh=ekBzmP/K177baWQFawg0cKaOFRTvEhVGG5dvfHdMCos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s+4jNVKeLpfZKw9+apafYB7Xqu3Eq7FwdH62O2aNRfAbYLERNQGktQfp28c3qKzHmeaMRmlK4gAyq/YBcVG2i7HpdgvKWHd6Hjzmp9jUTZNgp9fyogGD+PNku+Ifp1raiNtMWBFtSTDgyEiAbbwZRGbrHSl1Oew7wM3X9CZgKJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KCDyIsX2; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjE1hdMJ14xln+mkYoA8AYOY9fIxu4V4IDJIgNZwNjPIfDIOfX0upNiN1FP7SHYnSkvYyjqJYbvFjytEeCWg3SbAPKa3JdhS9Cr/RyDoXP770+LqRWcpvaBCZCDS8tA2Hy0Jt5VagyeBtO1/SB7ZMf0FOXxINl7AlzgIbjkJt/92VS3yTFnW8FzU6xCx9dMzs31R9/VRH+QFjg5oAW2sZuwDpJyqQczAa0aq5++Hjqjvwjx3IVEfc8yvOnyc4j1sMFfENZauG+sAuDw21eqHLwm9ZtxTipGvvBWx9N2heVt2QsE164DmIlWZqs8+cN5gumAMYV0vMp7pNmX/rO3XeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7+hFXYbo3fnV3B7V4QrBlQv3sO18cgfOhRHLwJklNY=;
 b=ANVnHuxrRFxwvyPCjVEoNdm1e8ZMCn40zlLrxFryKGPNvSLhOqoO2Ds6QCMB9MknOIgUAJraeUjmDoCQNVYuOF2/43C0nkO5qXkiTtd/hL2zchL06QHVJSjqWcJphodInPkYmPj8SFPA3XjuEWpUnHB50gtjoLgACFFUaFKeqqEURVo9tCpF9j0A129n4jvyFHWtpQnryRUQZFhi878lHTFMPcj7M798Y34k9U/c5Vif8LVEWr9QIOmaLeS95LFt3VENNO1kRuv5a5JhtHuHcoBrrDkgOzCr+uHgEmvtpWptFJ9ina+VhatioYSwN3/XJzw5DwN4tVA3nE4hILdFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7+hFXYbo3fnV3B7V4QrBlQv3sO18cgfOhRHLwJklNY=;
 b=KCDyIsX2fV53x7a6lMfZhUIQIy19U9qfvDXNocXTONyNYlmAAqN1Ssx1fNEHWFzJRt0LxpzCeFMC4xiEzeLgWMFgVQEkounWdBfXXZv0Q6WeQ58UuLulLQXcdO3E8IGSwixdM7IY2X+EWU7McySgCL6/+XBH9sAMWqhAQfafuB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 14:26:12 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:26:12 +0000
Date: Wed, 13 Nov 2024 09:26:08 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] x86/mce: Remove the unnecessary {}
Message-ID: <20241113142608.GB3181969@yaz-khff2.amd.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-7-qiuxu.zhuo@intel.com>
 <20241112154335.GD3017802@yaz-khff2.amd.com>
 <CY8PR11MB7134D5578EB260FEB1216353895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134D5578EB260FEB1216353895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN8PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:408:d4::33) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd6018b-5d73-4a94-60ff-08dd03ef1fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tK0r1RTZcaTaqWlZ4FDk/LgWlBKYBpPFoH6ThYZkc0mscyxJbrDJ1beK1XXq?=
 =?us-ascii?Q?IUkWlCsk296YcPcTIweWYceJbIcHZTVMKlf1AmlxDHFcIu96RMNg/GBVVI/T?=
 =?us-ascii?Q?40bUqnKv0ak2XXhEoh9aQ1+37QWbVhc6v99Wfo//Gnd+rSk8GEAewY1wdvSf?=
 =?us-ascii?Q?07c0ADxXqy7ujl45ALT6vD7778Qqow8KubcHc+tX0WYLg+k5Pngze4SW4w9p?=
 =?us-ascii?Q?r1+vqo5kjRAQkj++Mj9S0aimwQdUj+DysY9IHrGF0WYRspaga9yvDHy4CW4o?=
 =?us-ascii?Q?secHvdKdmUbvctSAV+UCm07Pvn6TGUFvddQ2gjG1ypb+uM/gOWdIzJSe5UJ7?=
 =?us-ascii?Q?SMAzlJs6BRKmcqqAXqASD21E7CuWwlZFqbmgSF+vSCBNODOuDNrQi73YApz2?=
 =?us-ascii?Q?PE8X5f1E2AbVP14G35rrrL7UFKJZ3NLZpaAbbDBAtzkEkiLxPEuztQcvTZ7F?=
 =?us-ascii?Q?Sx/cjaHd6QwEwGHXW6YbnxcQzSh3xqUw4NjMFTRvrmQizpHd0DJfbp/6Gktm?=
 =?us-ascii?Q?fX8Dqxuk2FVXeLiqxHpV6ZcwrDf/BNT/zmLky1q5+3Bu/wWlfBu5Y2S+YmiC?=
 =?us-ascii?Q?rHMMeWouBADuCzpjietMej46AYd8SElHsm+cjD9m+L//+sGasVdgpx7I0Vsd?=
 =?us-ascii?Q?MWV5/1jIgtqdo1ew0ZfkTavZqk9HwWwxq79zrCs2UkLsa16H64HJdwS72+jC?=
 =?us-ascii?Q?EtNpu0RBIXL128XU8OFZhMFwT6GDchPghR8JEf+Gs17SbNzDEuothW2noc6d?=
 =?us-ascii?Q?/+S/MnAM0iU2HjOXxg15nh9qWDJgmTSDOfp2Mn1J2FmEEJzVSVNXpaCHFlQI?=
 =?us-ascii?Q?pgCVoTEydI8Dqnk/0j8w7QCmCfRrjSYeCTuFO+g6hGkUYU06S6EeESiBbC2N?=
 =?us-ascii?Q?PM5kJH5EsHedp2EJmChKkHXibsm6cvULJnCeuPuJTJxoA5wuwm+MXq9ok6ZN?=
 =?us-ascii?Q?ck2xj18jtaoRtYPsz24qN61yzl9F8CjEblMRhtPKejWKchDUjIeYaG5R2/3L?=
 =?us-ascii?Q?XRRmAuhOpCbVHO8KSSWsKP3ps75sW/oeE4gMJZIhOgq/d7Z7Mk1P3ZWR/Rb+?=
 =?us-ascii?Q?YGSfv7iCt1oqPil8dTOQzUUb1sxHkRxXS21Z9PkLRfED/+bvfDQ17Ovq9K0t?=
 =?us-ascii?Q?IwDcuO2VO/KrOqqkPXRBNHtX2Fuc/3EFf8IkmsLg16ynBZ+4xcDdAhimtH6R?=
 =?us-ascii?Q?d2TFHZRLNppF8+ou/aZaKvRTtsfmlTufGO1zluw8HDVLDndp58sd3IvNrII6?=
 =?us-ascii?Q?Ya+mfWlKIlPnXJmZ+61sNXDIsoTEA6j/X1me17PC2vSU6/zD1fT6IiE3wWjD?=
 =?us-ascii?Q?nF0X1lqfpJXACQkqk38Sds6k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PFcHKEsL2Q3SD2hegCx+owWG5JC5v8N2I5canybU2sQJlrjVFZfpIVP47oT2?=
 =?us-ascii?Q?YZklewMNrE64zvmlqmM4ObIihWoQtKI4X+Du9DnBXf3CEDk+lf0A9LPlIq+I?=
 =?us-ascii?Q?9WyniDm2mEerpP3AUq1r0SEi+ewvFTCol/T9PP2+Ap9aFTTbcE9WKxXSPzY9?=
 =?us-ascii?Q?QMVSMT3bseBc3gS6obKgpUGAgKufEMlDblzxjrhn+tv2mS4RueH6FQBfpdyq?=
 =?us-ascii?Q?w/jhirkaak1sHrF1Dn/jlztRf3X0YisVMPWH2OAS5IVhxA/t7kOvjmxObK5O?=
 =?us-ascii?Q?0pbGjOAGhEWRgu0IrcfYYt0P+HpJKUpuQ9sWOqSuMtkYNj9AVEosw7I3EBlk?=
 =?us-ascii?Q?sUcE6fyNq9eYQJeNc/u+ZT2itT5BQsDENzq0+HGR/p8XSI8PNNQANVrwJEep?=
 =?us-ascii?Q?LGttOMcjW4FCtzJwLaPcLD2Tfe4nxg308ToTpt+6QxL40vgTyp8teNMBQRuJ?=
 =?us-ascii?Q?MzV3o39LmOlM0F6TjYTMJpaOm59DWmVMF4CS2Mxic17B9Swr3BvU+2FRDfBH?=
 =?us-ascii?Q?WWUBAavCwD2jm9EtyFsuy6+9gGepbwrPTcqM1QWn5rqDQvFFHugWGhrktIlD?=
 =?us-ascii?Q?i2CZmitOfL6vUFhvNn/EfqCBxBFiJxpg9OBQm7HkftDB9RAhLnqt8GAw+gBP?=
 =?us-ascii?Q?XUrbg1gHNnCCqC4k2qAzp4e0Dr0N/xAHtx23iknV0MJXJI/ibusfpnBY9aX0?=
 =?us-ascii?Q?LjwIVR/NMyqE/NAu5zLivcIvTvGufuBT3qj/1SQE18aUV+864eZZWYbc4Jon?=
 =?us-ascii?Q?5o1vycK5mjXYmRycw6IB/+l2o9UKyk7IyD5Zho7e45PdhUz3T5aN9TzQuQ1z?=
 =?us-ascii?Q?VZGaybLE1DLjm4knsS54yseKzO8Sf+YNdrMvqDaS835s7YlrjyxhdrNqJ9OR?=
 =?us-ascii?Q?jdlR7fZvrQopeyF3dWwGs9ZJaoFSQEFnCPYeNtWJeJ1tlqe/F9NlZBLH6AO2?=
 =?us-ascii?Q?eMlx+WraVIFgGd+heHyRWfvL/v7shC7nANcRxwVNGSmko1mIV0ZNXsQWm5q0?=
 =?us-ascii?Q?Zi8K6kJCRyJExGSyA8Doz5olmhexYQ2BvGpyJIzkV4CRHTePk7TfCKAklkAo?=
 =?us-ascii?Q?WCoXd8l6/pO/juCqKOKghW4X/BWEkCq2kkd9R4LFgUE0rXMDF7uOzxoMsAuG?=
 =?us-ascii?Q?ZxgfFrWhlAY6sEbqlKuhsWDmkw2moikNiAkaJld+Ohn59rsqKYRdeKw1CEq6?=
 =?us-ascii?Q?DhqzuMSj2CDI8xS+JAi94ScCi2GPclO0wRrS+U4kRE00kpznZ9u58GMRczqe?=
 =?us-ascii?Q?lDWcFCGiEUwIYorI674Fl98fOAN99tSJaPgpvGTIp62jO+R6CnzCwnFQzbAX?=
 =?us-ascii?Q?gNpY8p9oPDTJ+6m7lRtFrdYz1kIePCKSoeY3tMMkocaaPS26GFftU1Km54IP?=
 =?us-ascii?Q?xxFeeuqOQCaI6GT1v1ZwAqRYNUlLHsTHujzo9Mw6AMAu5oKHOkRNPXHKoGBy?=
 =?us-ascii?Q?um4pcCe32+vy6sdS7h95090j8COWok0abxJtX5V2/arRekC+DwlA6aGHfRoG?=
 =?us-ascii?Q?SxhxPaoIShi4Ft/bhdu8iHKgcOWKhSahT/ZON7x2oBS4USucBbrl5VtJxBsU?=
 =?us-ascii?Q?B/8F1PoiWlznuj8nad12121k31sw5kcCZCwa7vUo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd6018b-5d73-4a94-60ff-08dd03ef1fcc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:26:12.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BICEhceCXhiUj09nXf5qpc0TCFpP1IyOf978t3KmSQaqE+EXv43pF6svvgTjgsW+Q8ONoUPA/0Vbz/cbOcolRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487

On Wed, Nov 13, 2024 at 01:32:08PM +0000, Zhuo, Qiuxu wrote:
> Hi Yazen,
> 
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > 
> > Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Thanks!
> 
> > But please see note below.
> > [...]
> > > -	case X86_VENDOR_AMD: {
> > > +	case X86_VENDOR_AMD:
> > >  		mce_amd_feature_init(c);
> > >  		break;
> > > -		}
> > >
> > >  	case X86_VENDOR_HYGON:
> > >  		mce_hygon_feature_init(c);
> > > --
> > 
> > I think this could be a bit more substantive if you also combine the AMD and
> > HYGON cases. And remove mce_hygon_feature_init() which just calls
> > mce_amd_feature_init() anyway.
> 
> How about a separate patch for this? 
> If It's OK for you, I'll follow up on it after the current patch series has settled.
>

Sure thing. No problem.

Thanks,
Yazen

