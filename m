Return-Path: <linux-edac+bounces-2161-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B629A5A5D
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 08:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966321C20B0A
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 06:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A701CF291;
	Mon, 21 Oct 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dm1+ndjG"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495A199E89;
	Mon, 21 Oct 2024 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492192; cv=fail; b=myFeIHBi6vgO3O/hiMTIJaNBFbxYM+13bjTJEasHNEb+r0Svheq1kMAekgBwq7nC/fV9DNwG0gmhoR7Mz82Uio4fZmm11m/QMIgpfoW1JimbdcqZxOCaTnt/W1nNmbXNGUmvyiQAssj7DGBzcARwko6fKv+6zd+C6hQbU/TqKAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492192; c=relaxed/simple;
	bh=tV2vPadRjBdjkLQVKIF1z0S7NqV//hh1TQ/30MGYL40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9IVwdTw6Af+FNKcwuB2eKJ0vlIZFfSQAkj4qeeu16ET0YbCuyK8vvkOJ8DpXGPHuWVTLk30SSRx6nFHla+puQDm+Cj8yiZ8wIuka9ID/ks9B1zWlemQ1RycRB6CR0K4f6HfWdSlaUakON8VOBWMVrIzbswCcm5hFEpCG9MJLcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dm1+ndjG; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQR7zcZ8tffsPBR99dup3jo/caRb2az4d7XFOy/Tayxi082s+XdsA3VEZhlw8pzPBGWOlNyumkQ04Op7bwGGw/h+Pl4Hkx870tEysKLwC1/9FrmNFbQk6I8IqJBJEyHCkq9wxL79+xaAOy0r1Q7K/BdXrbCd56oUM1DLWzfqDivy43ynLGoUP5r7zdP9kgy2Pl0Oc0S4EPJn/9IZnJ+hFBXSQHyqfGvgxs+XYfHjQNDszduI9Lt+Mpbl1XkzV0zqIdhj1RcWhyvlTf3jYJ7dS0r1vL1i4Iy9JoXIHmZVB6OXXIqC8WRLSRYIrKT1Tr6eG/PshEQPSZnSsNbYkyHxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJcdd9CMp/q5fuPe7EKpg5+A7U9HPMvjwY+9LdZgi/Q=;
 b=TZUrGqXxcu7I/jre3ThlmREqJ4z/eHHYZztp4GYNnYjuEmRJmQSZN8qLJiR5duS1VeJ291KI0J0E5WGcTBTaeDxOUUo81ETQfyNfEIcl8xbu2SGOHCK1fFq22ef9BaB3wR1AIjGakSmzUNUOG4n8Re2YzTVJomlxKqGDbVvEEQa58+y/eKtxM1L0sXH2WqHCBpv7BRn/xX37Mi1T/S75RYHqYdoh94Vo/nbZkt3Efe2tY/AC++Q120g+pYduKOk/njvnAnaUjoaXo5eDiQlHqjVqku8Ji3od4wwlMejrcnijT7Z9I5NyasdCeRcLRrBVv4W51lmrboTjQkukAMR3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJcdd9CMp/q5fuPe7EKpg5+A7U9HPMvjwY+9LdZgi/Q=;
 b=dm1+ndjGpdN+YZj4yGhQ5sddqp5SOlIaLuukMtuNzdFVjymKCuC90BcGTGxuwA6y4bn5CeIujF5Fj8skcE9fCQeHLLLB8362YzyqaVCfiDGSPNStYtekud0S1rnaT68yRbRl9t4c6ABfr2bXLklpSOgyRwMD/5R+hug1+EyDyj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 06:29:47 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 06:29:47 +0000
Message-ID: <99c613f9-01f6-4322-a5e0-be035811076b@amd.com>
Date: Mon, 21 Oct 2024 01:29:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
To: "Luck, Tony" <tony.luck@intel.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "john.allen@amd.com" <john.allen@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
 <20241016064021.2773618-4-avadhut.naik@amd.com>
 <CY8PR11MB7134178B954B4DFFF6AEF81689472@CY8PR11MB7134.namprd11.prod.outlook.com>
 <8c71d83b-4dd2-4411-aac2-81284bf3a9df@amd.com>
 <CY8PR11MB71346E0906C0540C998730DD89402@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB60838E591B5E4EE1DED07869FC402@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB60838E591B5E4EE1DED07869FC402@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0011.prod.exchangelabs.com (2603:10b6:805:b6::24)
 To CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: c9702e6f-c4f8-474a-b25c-08dcf199c220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG8xQnEweTlxMkVHV3FOaS9wTDBFbFZOaU5iV1Y0SGtSb0d1TGJsNzF5WS92?=
 =?utf-8?B?TGF6ZnZ5U1VDcWpwQXlqbmhoOElmaWV0a3NLb1lSbnJ0TDdscTA0M1JVOXdO?=
 =?utf-8?B?L3E1cm8rSkh6N1ZQaUxUeXRjNkJiaUgzQkNSVzNuSGpEZWZxNkgrSHJWWWZW?=
 =?utf-8?B?cGdyMXdHa2VDbVR3dGV0SGxreFVhMDhtdGtVU2laSy9laVgyOGFydkJ1SUdH?=
 =?utf-8?B?b2o5d0NTWnNockNvbmlNUFJXU1ZiZ0VQTUUrd1VMRngvQ0J1WWlqU3N5eXov?=
 =?utf-8?B?OFdEUlBmWm1RZVhGQ054RXZjTFAxSjVFVVRVdHNtRExlUnN5aFpJcFh2a2h5?=
 =?utf-8?B?Vzd3SndrRUxSVWYwMjJoZmgyRVJzanJNUFh3cGltMlI2WkZCRG8wRW5iNUVa?=
 =?utf-8?B?bzhXQ3p3M2F3RmxYUTc5L1dKN3crTkJPamIwNEp2dnBXN1VJTzFwU3A4NDJs?=
 =?utf-8?B?V1Y5QUNWNVdWVW81L1pnKzQ2TGc3c3VLaHhCOWNQWVFheC83dUJnMCtmSFFw?=
 =?utf-8?B?S3lSWU1KNVhjYjBrN0pzbzBzTWsvOGR0QmJsT281UFg2bjlmUUpobWZWTjM0?=
 =?utf-8?B?NEtOdEFjU3g2TGF1aytKdzBnUU5Ndm9GRjhoYjlFQmlWcU52VW56dk5ySm5E?=
 =?utf-8?B?dzMxRm42Tm5WNGtQbGVMTTI4S3pjT3F5cytZWURKam8xZkxvVGpHeXY2aktC?=
 =?utf-8?B?VVc1VThKU1l5MitkTExsbzdCYzQ5bXdaeGZYUXhrR05FbHJ1Ym9sUGpvK200?=
 =?utf-8?B?L0trTlJzTk1LY2dHRDZHKzc1U2EvQ1ZSUW5wNjNnNnlMbTNaNTcwSWNkbmFh?=
 =?utf-8?B?SnFjTlJCa2VyVFI2QXVXOFhhQTZkWVNkcTFIVW44dXdmbnBOK2t1d0lYbVFX?=
 =?utf-8?B?NEF5SFArK1VGMWNYMUhueUlwQ3pENE5zWXdhT2M2anFHVWJtWXB3MHRPN1Jy?=
 =?utf-8?B?SnpVZHl6WWJLZVQ0UGVyemwwQkVqYnJMbEs1Uk1kV1VDcEFyYTUrbUVzeTlC?=
 =?utf-8?B?bG1jWURGbVY5NWdKcWoxNlI2Ukt0Rm9PSDBJY1lOWVB0anU2dVQwYnA2QmNk?=
 =?utf-8?B?dDdGOU52anBtTmovQnJFc2tmUUdIUkZsTVhZNVQ5dTFoZks3cWZjcmhCaDVR?=
 =?utf-8?B?MHI2NEV3Tk14S0JMMmJkUUEySXBNRjdlUVYwcFJwakgzZkpXeXErUjJyOENw?=
 =?utf-8?B?dVJsWFF1ZEo2RkVYL3g4cExnSGxtajB5SVQ4dmtzLzdRdDZ0S0RVQ3NlNTJr?=
 =?utf-8?B?N3R3cVRGaWwxaysraHNRc1R0ZVBrbzZEdmhBZjlNZk9mSFdBTUZ5SjdXV2l2?=
 =?utf-8?B?cmFHNTJmeDB4ZnBoTHZTUU55aHB5eC80K2h3SithTm1ZWGhwWkFTYjBReU1Y?=
 =?utf-8?B?bmc1Y2twTmRHYkJvRHdCOHdOb0l0UkIxWVpNWTEva3I5Zzh1ZEJCN1RxWndL?=
 =?utf-8?B?SVBDZHFmaEdZeElEekl3Z3p5NHErRFBGVURiUFZzaEwrN2pJakdYV3ZiVWdx?=
 =?utf-8?B?d2dMdjJMNHYxTjlXb2ZBNG5BSzZkb2NpRDFUdjBtcE45VE5nMlluV0xGc1k0?=
 =?utf-8?B?OTdaZzRDL3N1ditKSUtlLzhaOE5DSmpSV210eDBDTjVZKytqNDc4cS9lY0wx?=
 =?utf-8?B?SVJOTXZWY2cxeU9QMjVqZG1JVU5hcGlYT0FMZHBSS3d3M3JVUnRjZTZUMkhY?=
 =?utf-8?B?aDJyb2JuNTdhRktLS2dvNWpGa2lEdjlVV3ZWV0gydWI1QStkbG13YXo2WUgv?=
 =?utf-8?Q?+rh/faQnJcD2+fssaegpnj5chdwS20fqDqPmYrY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDZmaUZpL09wanhYV29GNjJyV29qeVJlU0RVVGM3U1B5aC8zQlVxTStOd3Z6?=
 =?utf-8?B?SjZjdUo1RFpCc2lQRVBEMmM3a3N3Q0hjSEdtNlpTUThhOVNYQnNtM3hyMVZt?=
 =?utf-8?B?SVllRnozTnExUUZtRVRqS1pBUGJhUWd3bzErdHlMdHVJV1IyMG5COG54YkJa?=
 =?utf-8?B?djZaVHZ2NU4rQmdPa2c4a1JpRUd5aEdHVGZ3UCtMaHhoWEptNVNWQkFtaXBu?=
 =?utf-8?B?M1JnNjRJTmF5WkFkMHdlYVI0ekxGN0VBOEI3OS9HQ2N2VXZzM1M0NUR6bTB0?=
 =?utf-8?B?bWRIaU44SXlJZzZoZXhKeUc4MjRuWlFPNmtyVFVranZBdnQvbDh6dTRjMm9J?=
 =?utf-8?B?UHd6ZXdKRTB4UHVuWHBvemRFcHc2eHJSL1VjdjNvcDBDOWQ2bDJFdUVGSXdY?=
 =?utf-8?B?L09WaFJHNmdraHNibEltcFNGVFg3ak5Mcmk2cjFpa0pFYm1ka1FxcEJvTGZD?=
 =?utf-8?B?a0tCMkdmYUs0RkE3RDgrcE16c3dBV2ZyOXZiZjRyV2dIRjNZdHE1dTRYQTcw?=
 =?utf-8?B?U0RRMFc4MVJPeGxtb29IKzBLeEhFU3YvTXZQTmdPR2FDNXpvTFdEWTRyclhL?=
 =?utf-8?B?bkhicEFpMS9QVFpVQlFBcnhncHVrTWtUMkpXWWJRbzc4MGJjbUMrcW1iV3Vu?=
 =?utf-8?B?TUk2VnNuL2VRVXFVV1dhbFNNczJQd0dJUWZZUmtnemZJR0xMZ21WdHRWOENY?=
 =?utf-8?B?bTBvM2I3c3BlU2Q5RHpac0RQQjlIOVQrQkZDRXh5SHEzY3JwY2h5WFE5VDVC?=
 =?utf-8?B?cXUzSERpbWI3TVZiM0Rrb25DR1dQMW9JVXhIYVRUSS9keGVVV2FMVzBueWx5?=
 =?utf-8?B?NWhGTGxSRHMyNjRjakttZFBHL0xZMCtyaG9rSXg0WWRlWTh3ZERuaG9oRUZQ?=
 =?utf-8?B?aExsUk94a1hYMkh1RE1tSTNUNkgydktkZ3BlcDdvZ20yOEZmV2ZONVRmMVh5?=
 =?utf-8?B?Ry80ZlJXbVNka2RXQXZncDIwUG1QMXRWRXpwRGxocVZnU2w0elVreVk0YUZx?=
 =?utf-8?B?TXlVeTlhM0dZVXJFbWlTVW4wUFIrWTRxekQ0bWRNQUVpa0dqNHB4bGRlNUZ1?=
 =?utf-8?B?TEVtMlRUR0hiT1ZWMG9HYjNhcXh1Rmh6REtGVi95cFBjMTRRaVRQT3h2aGZ5?=
 =?utf-8?B?aURRVGRmVDM3ZWZOZEdSVFJ1eHZpUmZlKzNvekpubzFwZzdLQk95aHRkZm1Y?=
 =?utf-8?B?TFhlZ014UmtzVjdrdlpCcTdXdUo1OFRWeTRmRmtFQy9FZ3FBL3VJRVk2TCti?=
 =?utf-8?B?YUU2aC90SUVYWlp2Y01mdFBQNEtEK1VDc01CbmdZNUt1cWVkTHIzY0t5a1Ar?=
 =?utf-8?B?K2xBM1FzOVpRRmMwK1JKVGljMnE3aTZoVDREMnRja3prbWYrRW1kT0hlSExK?=
 =?utf-8?B?ZUlKWUdZNzM3MnBjVDVrLzJrNE1OelQ2UklUQktkL0hHZktNRytlM0JUeTZC?=
 =?utf-8?B?NVNkOStXZ1RDeXl4VlFZSXRCVndYZVZaMXoyMDE4U2t6UTRoMFFRbHNvZlFk?=
 =?utf-8?B?amo1RGI2Vms4dnNObFlBSkRuV2ZnREVmdjQ2bGJ2ZFBzekJVV091RXQ3Wndp?=
 =?utf-8?B?dHBucURSRWNER1RlY29BVm1Ea2wyR0gzc1dnNHRFSmQ5TWx3M1VrQlZIQmZP?=
 =?utf-8?B?Sm5FWUtsMXBENUZOTE9ackdIclBKUDVOL0EvajdrZ2JrSjkzbUxmR1l4NnNQ?=
 =?utf-8?B?Mm9jMksyVTY5RGZ5aGNQUVB5blUrYWdRd0Q4MWJqNDVTcjBFc08rdGJlODRx?=
 =?utf-8?B?dUVlQm93bzNJUFBzRG9oUm1aYTVhL2NPalpuWU5SUkZwREVaZjlEbUVOUmpY?=
 =?utf-8?B?U1ZQSHRzdTJRUE1mSnZySGdNWkR4ckM0R2lGSUxycllyUXFJMTVXVk05VXlp?=
 =?utf-8?B?bXlXbUJUL2FxM2JxUnZydEFPOWVDTFdpOFBLWG4vL2hESS85UUVJSXllMnhp?=
 =?utf-8?B?NldpdVRvdnJhNzduWTB2SHRzR2hsOW54QkNLYlh1WWlhSWNFaUZneW9qckE2?=
 =?utf-8?B?T2w3SElIa1pNQVZGOUdTWHR2dGM4UVNaQWFRczd6YnJ3K3V4MHVpT1lvaGdE?=
 =?utf-8?B?cGUzZ0dhNWNXRWdLRkdZd0RRMmdtZWt6cVJPRHFqMDJkMmIrZnc0ck42K1lv?=
 =?utf-8?Q?GfBD8YyG1862MUsCZt8hgFu58?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9702e6f-c4f8-474a-b25c-08dcf199c220
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:29:47.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6wt9jkotMODr7IXAh3q2ixBvAr66vAuaUyZ3l2sDO04Y+XMjT1C9OPdZS436ubjYJzk5wq7hZ91TY6q2FO7cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659



On 10/18/2024 10:28, Luck, Tony wrote:
>> So, this is based on the assumption that all vendor data fields are of the u64 type, which may
>> NOT be true for other x86 vendors in the future. In case there is some non-u64 vendor data in
>> the future, the parser would need to break the u64 tracing data into u8 data and then composite
>> the split u8 data into other types like u16 or u32, which seems even inconvenient.
>>
>> IMHO: Printing the u8 tracing data and leaving the vendor-specific tool to parse the u8 data is a
>> more flexible and balanced approach.
>>
>> Maybe Boris and Tony could provide more comments here.
> 
> I agree. It's hard to predict the future, but there seems to be no guarantee that
> vendor specific fields will always be "u64" sized. Perhaps the MSR that data
> is picked from has only a few bits defined so we elect to save those bits in
> some smaller data type.
> 
> -Tony
Okay, sounds good! As recommended, will change that parameter to sizeof(u8).

-- 
Thanks,
Avadhut Naik

