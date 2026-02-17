Return-Path: <linux-edac+bounces-5723-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rFa5GzuIlGmsFQIAu9opvQ
	(envelope-from <linux-edac+bounces-5723-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Tue, 17 Feb 2026 16:24:43 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B622E14D8B6
	for <lists+linux-edac@lfdr.de>; Tue, 17 Feb 2026 16:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 487E53028B09
	for <lists+linux-edac@lfdr.de>; Tue, 17 Feb 2026 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EA6280A29;
	Tue, 17 Feb 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wQFes/KK"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2823BCED;
	Tue, 17 Feb 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341880; cv=fail; b=U4YYvvLyPvzyuKpQCKYwVhpaTxxXM3HgAMIRPmfsPzChu/mamebT1vFDCIRotAFtjh/KgCmdhAxbr6eL+5TA7qpvolKNXAI1qKWoPXCWwGumX7BIPM7+MWm6M0SVk4lI8KLdSwdc0NfzqiW5dryng58YOqmEBXS3FB9dFhzSwkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341880; c=relaxed/simple;
	bh=3/0lL2OjHBklFCD7nz0TfXTt3w0XZHIuQtnBU27Zwfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tJKvqRTac9wu1fRLsWNb19zCdHhSKiIXFMH3VBM/NEHtAOR8afYyND4pDmrlphJEG22ZflpV2C7fAaVmINCVJZa+PK78ZQ+1jA9i6fhm5/MD5VoWKQgOHJGo0bWcNcFChqXPVRV2ayTlXfxi2uBuVbBeeBrbvxBA+5Rj6DtGvBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wQFes/KK; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r25GwAO68BennzJljCh4lUWKgDbXo7zMM54G1nWuhwP+7YZs/s9Iz76yd1xreGcvCd9kyGjd1D/bOo7slqH3NPYkhoC9Ljl4ht68ONrm2eqitOoj+MPzmFiZD6uUOh7ra65SQOzH0me/sjacwEtH3XY9achUQ3FOxub9d16Ym1avV6JbmCZDRpgJE3LfEjhdoEL8YiR8ygSDdxNONlVJ4ijPhLsgVcN+St0ZPsA1956PGjzDKj+4AX++qU2xyH/T8uv8ZUR/r+RKGnWDR+V7HYofHRJtR6EP1krtzLawXSmbFA5nIM1AzHh+YS02tvhTwnejeJJpFfrUPtfTy1o4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW1TjbXYxeFGvnGHLYuhOLcN1bQp+R5xiv2UBH3zgUc=;
 b=omxL16WUGuArNWyRCheoB7AjjnUw1a0PQDsoiyPwi6SMjU2plhLe2kDVCvAgWBLdaNqmZK4LSyRuSTMj19/52zCqZJ37Qy6ZAYfHVPCxeRmNRm2SUrBudA/CeDtC3zFuuMKDg8MH/bIwxUIPcCUM03Hl/AcHvNNO1+I7O8eymP5YJbhYRynLwEokX/KSfgUpItdQhhazlzeSDLqvwsgStMMYk4clFO9m/+86C7aIJmFrf34s+9xnA6yHdcWAUfXFlpu4C8MlYvLBR+W24rWAD/w90tx23to56jYfKy4WZk/10/K6muyMgnSVWM0WavaMRMbMSVdKf36SaFT+La3vwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW1TjbXYxeFGvnGHLYuhOLcN1bQp+R5xiv2UBH3zgUc=;
 b=wQFes/KK+OudvJmUp4LqpZSzcPMGBU194KJcCkZGPw9ClHyfOxlZ5jGG2Lh+HZQDtelBmXQDXE4Fs8EAFkb+mF4chMgLCJih5N75hEyQr/dk0aAbnbYuHu3aM9zmjOWXo2gOi3H8GC/4WM2WtF/OrPhnM8aIFt9+n3cF/Si+4DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Tue, 17 Feb 2026 15:24:36 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 15:24:35 +0000
Date: Tue, 17 Feb 2026 10:24:23 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: tony.luck@intel.com, bp@alien8.de, tglx@kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	John.Allen@amd.com, jane.chu@oracle.com
Subject: Re: [PATCH v1 1/1] x86/mce: AMD deferred error handling crashes Qemu
 VMs
Message-ID: <20260217152423.GA617258@yaz-khff2.amd.com>
References: <20260213182630.680651-1-william.roche@oracle.com>
 <20260213182630.680651-2-william.roche@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260213182630.680651-2-william.roche@oracle.com>
X-ClientProxiedBy: DS7PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::35) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 850b1a33-9298-4321-42b1-08de6e38a7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUI5MksxM25jRWJOYzhpc1lCRVhtOHQ5UnlhRGVKUlNYNHhNcmxPQno5Wm9s?=
 =?utf-8?B?cGVJQlZLYjh4T2FudUI3L0NKeU10RktwTlVudkg1Skk0R2hGWkxUWEQ0M1F1?=
 =?utf-8?B?Y3NnOCtoNmJRMDJoTjRmMUFLOUpUY1pSSXZGWEhTU2VrN0hDSVBvSjlOV29u?=
 =?utf-8?B?bCsrUTA3c3VXKzdzYXlTQVYzK01RY21NOHJ1ck1sMG1hNGQ4QkJJajZRdE1D?=
 =?utf-8?B?R2w1ZWh5bXg1RStTTFRTSVNKdExiOXMveXlySzRqSCt4SFBmRnZPaHdvaktP?=
 =?utf-8?B?YURSckRsRnFQK1NLKytWRi9ERzY4Y2J5MDAvWnh1UDB2Qk1DaWpMSkVIeGxI?=
 =?utf-8?B?cCt0ZlpQTFNjVFVvLzZRUVJyQ1UraXFrbm1WUHJyWk9LL2IwcDJuSm53TUpp?=
 =?utf-8?B?VFdJbUtQbEVnS0c4Y01GUDMvWjh0dzBTd25XRnFtbngxNS9zVVMyTUVhNGpi?=
 =?utf-8?B?YmZmOEQzNzllNFlpSXpyY0VHVHA5MVVIcDkyOTgwbUtRcmhxb3NXbTRhTHJm?=
 =?utf-8?B?UFdPNE9kTlo5M00vZSttYUVuYzlLT3dtQUdodGR1S1lRdk1xWlJhaU5tWlJm?=
 =?utf-8?B?Vkhjc1pJMDFXVE04Znh4RkdWbmtwZ3VYakw4QWRMTjNaa0Z4dnQ0bzQ2US83?=
 =?utf-8?B?WWxLQmFodGJDdG9LUWdPWEJjWEVUdHh5bWZQQS9qM2tja1NIbm9ZMkFsMjA2?=
 =?utf-8?B?TUJiSEEvMFhBV2phL3RqUUgyK0trbURHMld6NWJzOXZNYVFkK3g0NzRYQmw3?=
 =?utf-8?B?WUlRNFlDaEQzSW5pcytMMUducnFJcWYwdS9sQkFZbTh1OTdaTjJCeFphOUNi?=
 =?utf-8?B?dXZ6c3Vka3kyQWQzVHNjcGZqUEFDMllzb2ZDb1d3M1VOcjk4RXVtU1V4MHVE?=
 =?utf-8?B?QzJiUklBZXpneG1CNk5ienp4dDJlZ1p5N0lMSjh0WXgyK2t4NnM2dzE0WHhM?=
 =?utf-8?B?M0JhOVgzZi9seklYUkdmNFh2Zkptdkl6a2swa1cxN2FBS1B0Q0JxVHlQQUxz?=
 =?utf-8?B?TzZTMml3bHl1amRWWk8yMHdtQmdsL3NMZ0cvRVpVNmdKNG5oQW1SRExDRGlY?=
 =?utf-8?B?UlZYbjJWbkxiUXMzdm5sbGJ4cmIyb1REMzBEN1ZIb2dUVXEvQy94UDdiT3hi?=
 =?utf-8?B?dGFVVG9XZHJHb1Jtc0o4ZU4xTVhKRExOZnlBa3IzNnNqZ1B4eVVVYkNId2M1?=
 =?utf-8?B?RUFhNSs2b3AzczNjRnhSdUZUKytNc0x5WjgyTmV4NmUxeDE4TVdDRDdaV0Jh?=
 =?utf-8?B?ZktlaDBZaU1EZmJ3UU11NmY3d2lqNURWZXVVbndabFViWlBldldReG5aKzlm?=
 =?utf-8?B?NTB5OXgrL2dsTG8wZTNXRnYxSlpiaThiY0hFdmNCN0s5eXFQSG1sOWtZUmNL?=
 =?utf-8?B?VjNjQ3RScmRvSmZaaEJPeVJaYkswRWpsWHQybFlVOFZ0Z0wzTjY1eUpNWFYv?=
 =?utf-8?B?ZkhaNGdvaHBnUmh5bWNPSjZMcWdOd0kzNHN1cExmaFpXZVRrOTVuUHJDSzhy?=
 =?utf-8?B?Mm9tSmpGelJhQmJiMVExV1IzbXlBdSsvajdMZk5rdjFDbGp3d28yT2Z6YU42?=
 =?utf-8?B?QzErOWFBYXE2WW1lQTBGdGhjSXVoK0ZDc0JLekpPYmhFdmZGRXh3NllpSWIx?=
 =?utf-8?B?S0VTRnR1QUVWL0FnWlQ3cXpIbktBUUVSamZLcXZ0ODlaMXBDS3lqRnhEbUcz?=
 =?utf-8?B?NHVrR0VtVDl6SEFlM0I0cmlabDkyenIwU1Fid05NZ2tnRDdhaFE2QUJnTVlo?=
 =?utf-8?B?bm55NnMyRCtmK1VNQTJlQ3BRZlNSdjZ6RTZDM2dXbU9tN0p4TlhQaktYRWxN?=
 =?utf-8?B?c1JuZVlDd1FDQVlhV3UyOGpvRHQxQk04VDNFVDY0b0JMcDBzVFRQMTVMbkJp?=
 =?utf-8?B?b21CdllDNXZjSFNSOE1TNzhTMHYya1p4SjFYZm1laExFaEJySXpmMStYQ1pZ?=
 =?utf-8?B?TjV5RGJqUHZOTWp3SnVKMFZSdGR1bWhwNENJM3hzZWdESFU1bFI1REVWOU90?=
 =?utf-8?B?NjdJc002cEdMYzZSQmtKV1ZSek5vWm5HMHhVWmlURURLRVE3dHN1aVp4bHJq?=
 =?utf-8?B?dndiaGZySFhSc2lPZmQrMndGNjBtYVBDK0IxRmhNWm52b2YwLzh6amdRd1F1?=
 =?utf-8?Q?cbeA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RytqNGxyOGZPbitGR1F4eHk4SXRLSFFLMDkvaXd0YUk3QXl3SnhSSjRROFBB?=
 =?utf-8?B?TEV1dmI4NElqd2ZDaFN0Q3RWdU1QcjBFL2dNalFmaGsyOGRiM0M3czZVZG96?=
 =?utf-8?B?alRkSlM3UE9qVUlFNTUwdGM3OTBTSUF0MC9zMEpMS3kwT3NQbXlrbytxOW9u?=
 =?utf-8?B?eFlXQlBhc3p2RTFUR0c3dUhUdDJsUndQZ29lU1kvUkVyZUkwYnRLVmNLVzNO?=
 =?utf-8?B?VGF5LzBPejF5NG9ma0tLSkxRS3FhdEpuckttbjh5cE90OEhwQ201enQ4TUpN?=
 =?utf-8?B?YUlzSUlLU292NFZZMkRad0VSUzZMZUtRaDFnYXFoK21ubXg4V00zVTdqcTVo?=
 =?utf-8?B?U001ZHhRT2FmQm5US3BGUEwxeUMyVmFWdGN5RlF3dFpnNkxsN3FvZWxZUmpF?=
 =?utf-8?B?NVN3WlJRUld5RGZiem5pZDN4SkFWbFAyRTUvNTNkMlpVRHNTVTdtTitxUDZx?=
 =?utf-8?B?NmU1NEY4SmlXYU9YdWRRV1NFblA3Z3FWRWNsZXNKMU1wWWlQcDhEbVRXeFNi?=
 =?utf-8?B?c2hsa1Blb1d6TXFUbkhaZE1oaTMxYUk4NEcrbmtMYkQ3WlhGZ0hrVWc4bWlo?=
 =?utf-8?B?cEZYZVpBRzFhYzJxUU00c1FtNkcvUTFYWlo1VXhLTTVHeFptSkhxdGxnTVhF?=
 =?utf-8?B?M29lNFJkaXRpZEx1TU1JZ0Vvb01wMHNENUtQTW1GZ1IyWUR3SlhTWEh1Mzhl?=
 =?utf-8?B?ZUd6cW9HWGlDQTFCUjdmMExGOHBKUjZNRTB4TWk1NTNOUXoyWmFheGRtdkFy?=
 =?utf-8?B?UTdoT1I0RG9QQUpOcGZQRXE0dE9TUHlTK2ptTGZTcTBlcnJiQS9SdVlyL0VH?=
 =?utf-8?B?eHNlVFhGczY2bzNCL2lYckVLZmJZanVOdnJhZzJwQVRPRlM4VzkrUjU0dUVI?=
 =?utf-8?B?ZUt6STgyZ2JMTFQ0Z1B2LzBWdEpFWTIrL28ybHdIem9idi92VklmcmlTV1lo?=
 =?utf-8?B?UkxkTENkRGpIK01Hby8xV3J6WHdpZUhuZGNQTC91M25DdTBveFMrc2hCdThZ?=
 =?utf-8?B?ZnJob2JISVYxcHRERnhFdHgxY3RqY01kZU9QYW5XdFlMb2wzcnlZbHBCTU5s?=
 =?utf-8?B?N1FjRThxWS9qdTRLTG5ZTldjVUhjekQ3Vkg1NWlISUFjM0N6RHpBVDRqczBV?=
 =?utf-8?B?OXRvL1JXMTlwWjdxTHhhUEE0VmY2RFFyblVTZ2Qyc2F6SUZlb20zWEIxdEFy?=
 =?utf-8?B?SjVnUDNBamhXYTdXMVNhaTE4VXFTMFRwWDdJSVk5RFY4VjJOU2plZmdmSVB2?=
 =?utf-8?B?dmV4MUJCTHZNQ21oV0tTN0QrYWxPVEozWFlzQmVvdXNwUXZKYk4rLy8ycHhX?=
 =?utf-8?B?ZFBNVjQ5Ri9YdXcreEh1VlRhRStEOW12enZzZTJnaC9yWkZmMEhJTXlNZWhW?=
 =?utf-8?B?NVpiNzd2blRMejZHRHJwbEdkZjQ2djNmaTJwdFVjdXpXTVJNVDlUTUNBVVUy?=
 =?utf-8?B?QlFJZUN1dFFYcHZkYVFGUzVJQlBtbmpsVmpCNGhtS3pvOE9yUWM4OTROaWEr?=
 =?utf-8?B?UEpRWnI0OEVncnNNLzdIbCtsS1h1Y0ZEbG9oTzdZd0VLckR0c201V2RXUXBE?=
 =?utf-8?B?WXMrR3ZOK3g0ZUl2b1N0RTRqVyt0SlZvbE5RTkdnYXQxVE5nV0hUQnN0Q3lw?=
 =?utf-8?B?dktwQ0N6MnRQNkEwWFkxL1Y3Ukx2cXpPR1pOc21wN3g0a3pqYnAycUJvTVlG?=
 =?utf-8?B?YzBvSTlzZVpkSFk3NjREdlNPN1VCM1BLTlc2UlliMkxoUm5XWWcwVzE1WVVY?=
 =?utf-8?B?U2hCK3VURStnT1RZWmNjWW9OSXZocEthdUNQaXVUYVI3V0RMUk9IOTJzNWtF?=
 =?utf-8?B?TFQrRzQ4WHpuM2VnQmh0WXhtbnVkcXMzamM4WWVNSEJ4dm9tRXZ3aGJNQWhM?=
 =?utf-8?B?NDk3eVhKckRDU3FaVHdrRVVjYkYzWUtReDVOVGVBcndNRkk2ZXVtMHY0LzNO?=
 =?utf-8?B?QUtQUlljck9lWENnOFNITlc3TDZwcXdWdzNmU0JwZFpVZ2kxd0RLa3VtOWd1?=
 =?utf-8?B?R1pnUjhkZGJoaldraEFySlVpS2RzRVFScUVnMS9uZjdBdStUZXVSSFVnQXZK?=
 =?utf-8?B?REhETUppTlhCeWFZSU1QdnM5c0wvdHpkbjdwQThvanVNNUFXdzFYOTBYZVcr?=
 =?utf-8?B?MUJHcEh4S3dqZFR3N1pEOVhaT0JpOUw4dkJBUTl5bTRGdXlYelhSQmVGQWpa?=
 =?utf-8?B?R1ZHcUhFVEZBOGZ3RlVCRVJZb3BtR2dhQVRzYnhNMzB4M3d4OHo3TFZ1ejJp?=
 =?utf-8?B?NTNUTE56eFdzcUJnTzl2Nk84YnBvNzFkemhPWXZxUi90RUsreVF0c1lXMlBy?=
 =?utf-8?B?TGVIZktQT0NjNjVpdUVuNlZSL2VDOWxUSCtWRHFxNzltcUFtK3d6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850b1a33-9298-4321-42b1-08de6e38a7b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 15:24:35.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Azpyy/DDIgOssH8VckyDuEdiTvOnaliZmsnL66sE15gjxLMBMhYZWhQVpz7BGB27cKptx/+aV+m7vIz1rRzKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5723-lists,linux-edac=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B622E14D8B6
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 06:26:30PM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 

Hi William, I agree with the fix, and feedback is mostly around
style/convention.

Use "x86/mce/amd" as the $SUBJECT prefix.

Subject should be imperative.

Ex. "x86/mce/amd: Fix VM crash during deferred error handling"

> A non Scalable MCA system may prevent access to SMCA specific registers
> like MCA_DESTAT. This is the case of Qemu/kvm VMs, and the VM kernel

I expect that QEMU and KVM should be capitalized.

> needs to avoid accessing SMCA registers on non-SMCA platforms.
> 

The commit message should include an imperative statement.

Ex. "Check for the SMCA feature before accessing MCA_DESTAT."

> Fixes: 7cb735d7c0cb ("x86/mce: Unify AMD DFR handler with MCA Polling")
> Cc: stable@vger.kernel.org
> Signed-off-by: William Roche <william.roche@oracle.com>

"CC stable" tag should go after Signed-off-by.

> ---
>  arch/x86/kernel/cpu/mce/amd.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 3f1dda355307..53c4b032ad35 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -875,14 +875,18 @@ void amd_clear_bank(struct mce *m)
>  {
>  	amd_reset_thr_limit(m->bank);
>  
> -	/* Clear MCA_DESTAT for all deferred errors even those logged in MCA_STATUS. */
> -	if (m->status & MCI_STATUS_DEFERRED)
> -		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
> -
> -	/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
> -	if (m->kflags & MCE_CHECK_DFR_REGS)
> -		return;
> +	if (mce_flags.smca) {
> +		/*
> +		 * Clear MCA_DESTAT for all deferred errors even those
> +		 * logged in MCA_STATUS.
> +		 */
> +		if (m->status & MCI_STATUS_DEFERRED)
> +			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
>  
> +		/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
> +		if (m->kflags & MCE_CHECK_DFR_REGS)
> +			return;
> +	}

Please include a newline here.

>  	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
>  }
>  

Otherwise, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

