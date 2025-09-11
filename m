Return-Path: <linux-edac+bounces-4796-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2484B538CE
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086F03BFACA
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58ED3570B8;
	Thu, 11 Sep 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nYGO7io3"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44818352098;
	Thu, 11 Sep 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607115; cv=fail; b=kzmIJfyBt6KPPK3SNOTsCRF1kTHiN1xs/TAegPbGVN6o8s+knhuhQZ/NvPdC+pOf/jbUi659BbUTbgbPtZSpVq9xjrN/EGvWQnYeVA186ctlgPNPfRPb09lBIIDaZTEyokiHyuL52sfc5eewSKosTspcS2y/BYdWhhFktJU6lDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607115; c=relaxed/simple;
	bh=U1DKcr+vzxve3j2ZAf482yokiqVjpaCtzq2Bxufcc7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h6MizK340IjYguW1htdJ9UKJaKI6Y2MKR/EHy5aU3BL9kkHJorotSxEwnIOale/dxUyMPBHpXL8g7IdRwLfGX4gNCSpszMGCUmtNSViAHcDDkCDJRQwEDR7GUOI+g6GjF675BdY9OrDRzspyb3O89FE4S/4RnJdGFsr/uqODdVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nYGO7io3; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MC3HypX4N0wD7oLl/yCJ6YfNFnMusVvVJ/85DoeEXF0GtPAKvD1t/T1cSAyd9FrV8KdCLuu/8qmGEpJk9K5crNu73Rn9XZU0DCCRksNMRDtfxMy+A5xw78GOcnF5sqcomGhuBD+NeERX79j92mTR0gify/DisrXp2NA/8FUyCO9ngF7KrhUMd7RNhlN2ymsqYit9f94vFhe4oI09/EsVCl8C+Pxku/W/QpaqbS+ehhdWivmI7g0RAQ0fU/lP6LxrXmc+esR32/N/JqJwMm0GqK2f59MhYiDcF4EO4rqETPIyoHD5vzEU6UWpacmzEYYW+Cr0iR1/JeG3+KN1amrOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GHTFZVIIFQo1zqLLVxw7xfGiyB6SZTn4D9wlNfh48Y=;
 b=jPGZkoAOMTGSrCxiLZ1AME51hBAjNq/PkldPBd5CkwDb6TmzVsz38A1HPQD5bAfOTnS7P2Hk2VMqlRs+Pt6bHyOiH0T02Yd3wG0t1v8ImPMjn/qXoxG2OP13IR/sba3fyru44Tb3zW/+QGC5SsFw2e793NBfFVO35PtIp495jdi8D/8q4h1Kfdf3zGRbYkcCtKzqOQk/x5FbIoUj1Czsr59s8QoCC3D2iZZNk244g4bwL0DrlmOUGmAcMvbAspU3A6VNG22EQGnHv92ksWt/S/witQ3k3nyvQUO1mXRu8vjmnuUFDK+5RX7kKXuNa/BwnrU5+quOicFLLqgBJO02oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GHTFZVIIFQo1zqLLVxw7xfGiyB6SZTn4D9wlNfh48Y=;
 b=nYGO7io3Wll6uZlaa5AYvWKWPfOFH6gXkx4xPCFmFcNZB+eVWfGrGoJgxgMudJCHyO8YMbeKBVxTh6sNXo+2/SKHWUhWk/OZSXKVvAm565HLkTHcCLbxGGXYW069IC9zATnMhYBv7rFqGspwdrpKPpiqudlPyvlUdMkz786Z3j8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:11:51 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:11:50 +0000
Date: Thu, 11 Sep 2025 12:11:42 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 12/15] x86/mce/amd: Remove redundant reset_block()
Message-ID: <20250911161142.GB108087@yaz-khff2.amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-12-eef5d6c74b9c@amd.com>
 <e85965a9-3aa5-4368-95bc-c46ab18a25fa@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e85965a9-3aa5-4368-95bc-c46ab18a25fa@suse.com>
X-ClientProxiedBy: BN9PR03CA0917.namprd03.prod.outlook.com
 (2603:10b6:408:107::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: cce8cc4c-cc6a-4851-5d39-08ddf14dea9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mi9rcWtmdUtISTNqMzBCTmFsTGFUWXV4cWV6VFY3SXlocmNRc3gwUGJxQTZa?=
 =?utf-8?B?SWh1UkNUdGdReVhjbDlPdk4wVXRWcjNTNzJHTjBjY3ZoRGQzcnljRlFPSXJ5?=
 =?utf-8?B?UmltSVIySGdUNm1IWDZaUlNscnJQcVFwOE5VR1ZaUmtGVS94WFlqdjBaS1pX?=
 =?utf-8?B?NGF1TldDZjJTU1EwUWVHNVNRWUFHb0I3R0pjQ0dXQ2k2YjZYcmp2eUVLclhC?=
 =?utf-8?B?Q3JDbDgwUWdnMjhwdlJDZ3Nwbjl0ZVhHQXdqZnc3bE5admxmUG8wMDl0QW1U?=
 =?utf-8?B?ZFJnYm16bW5TUTk5cHA2Qi8wUHBRMFRmRmEzYUUzRVFUSjYzRDN3aExjK21T?=
 =?utf-8?B?MEt2RTJ0U2srSUR0TDB1SS9YbmwxZnRRbFA3bHFiT3VlUE5Lc2oydUZYeUt0?=
 =?utf-8?B?ejI0dkw0enVCSzdEaVdtR3Q2Nm1vZnRoam1rT2R0K3FFK3NWVE1kcENnVXda?=
 =?utf-8?B?V1NWS25kVTVaaGFPNXBBcVhxTDdvS0x2OU5veWVwS25CQUFHNW9ZQ243bDN5?=
 =?utf-8?B?M3l0UkR6b05CVXZINGtwMWtab3FqNGdqeDFrWXQ2Y21sNU05OEVVU2FoVGdx?=
 =?utf-8?B?QjBlWFIvQzNhcmlrQmxydjJaOGJlRmZwN3NiMlF0UTFxWDVJS0VFRFpMcGFX?=
 =?utf-8?B?RTlQNUY3S05kWmpRYkZoRlRQZGhqazU2VHkxdHF6cHFmR3JZR1EzWGQ4enU3?=
 =?utf-8?B?UjFsT0lIaGpmN2cya0RUQ3FLNTZ6c3cyTmpkMGk1UHhNcVUrMElQY0ZkZHI4?=
 =?utf-8?B?SFpZUEJ3d0hVSHMrZ2lnTWI1NFB5c3gwMXVweGRtVjcrOStWUDR6Mi9ZeHZu?=
 =?utf-8?B?d3hFMHg4RFhYT3c3TE5aUG1UN0pnTVlLQU96d0N0OHZuUEZBemd0clo2a2Fy?=
 =?utf-8?B?amZ3QmU0LzZVcjNmbDhMRm1HanJKWXFwbE05YStUb0hrVGszNVlKbVV3ZmFU?=
 =?utf-8?B?RlNjbTUrZ0lnRTM4MjYyNlNucXZNN3FZZE1sUDlTUlRkdUZiZ3krSWlkK3VK?=
 =?utf-8?B?WlU0KzYxZ3lXT2dJM004RmIxUUhYV3UxTGljOC8wRUlYeGh6eWhwMjY5aFUw?=
 =?utf-8?B?WnJlbW90cWtmV2xmdXhYeHpWUkpwWUFCMWs3QTJoQk1IQWZ0VzBSajZUdTZM?=
 =?utf-8?B?NHlCOEtFcGR6VWgzNlVPMnE1L1lCRHhsVDRzcmJGNWdQK1Z3eVFlNjFhcUJr?=
 =?utf-8?B?ZGUxazYwb01sTVl0M1NSSkZ0dC9ERWtUVi8wakVKZHlRbGlaOGpYYm9YV0pQ?=
 =?utf-8?B?UXhoY0dXeS9NeWd4L1pCdDdHQTFWOUk2LzN1NU5MZ3o1OHFJditnOE8yalY2?=
 =?utf-8?B?ZFc3VUV5anhsQmxLdEtScWEyNVlKbElYdENqbTZkMU41WVh2M1Jtd2Q0MkJN?=
 =?utf-8?B?TWlPTmthSk01U0poanpLK3BGc2ZCVG80QVpSYlBvNlczSTdlRHJMbE5mbk5l?=
 =?utf-8?B?Z2JLU1h2MythN3UvdlRBb1AwOU5GT3ZjWVUwaGh0YWpTYnVoQnplbTdGeUgx?=
 =?utf-8?B?WGVOT0dZbVpHS0lmM09GOVdhSVlNU2Y3aHRkZjV5U28xM2lDa0g3STFxdmRr?=
 =?utf-8?B?Zm5ZRFRVZzFPeFgzZ0JUYUtyOXplb21ieGNRQjQzZk9kSzhCSldJR1UrLzdY?=
 =?utf-8?B?Rkx5dmFQaFU3djRORS92M1VUc25QWGh5bFF4ZEFKcU1HOXYvVVk2RmJwU2JI?=
 =?utf-8?B?d2NOOVJKWWYwMExvQmhicDNiemZuYWRBNDIzSzZ4WHFyVExxa3BnbUhTbnRp?=
 =?utf-8?B?RlB3MjVPRTlHdE0wNUl2bkpaS1lXZFByTmQ4Y3RNWFVFQktobVNzWFFkYTIz?=
 =?utf-8?B?Y0wyVXJmWTV4a2lkQ0g5L01RdnpYYW9iQ0lhLzZUejl1REQ1cytwQi92emsy?=
 =?utf-8?B?YU1EV2FkSkRabExkdUJFOXN4WDZUMjJ0d2NHSENzQlU0VlBmK3dCV0hzdm5x?=
 =?utf-8?Q?WpNmArkQOLI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm52cFdVL2M0cVljZlJFUC9uSGEraWJXR3NWTEllSGl2OWdJS01ua0xHbUZZ?=
 =?utf-8?B?NjVxbFJkcGNPdldCQlFxRklNSUxSVEZUWkxpaWJZK1E2b2RJK1J1bkFqeDFE?=
 =?utf-8?B?MjBVUVNrREVIQjI2RzR0YzdkNnFDUkovN0dhbk9ueXoxcFdOTkpuUXZIdTAy?=
 =?utf-8?B?TmVrbzN4ak9SQ1dRYndDa2tJWnRhTDF1MGRxUTcrY25jWnlIQnh6cGZLUnA1?=
 =?utf-8?B?cmxmQjFUR2VYY1lPaGZHWmFoYW1NOXcvV0NMZzFrbkVqckE0dFNURWl1Z0Y1?=
 =?utf-8?B?aDlMZTRUNzZJN0J2ZHUxR2Y5RDNnbXA1dWdDYytTeUxmbjU2OFlabW1FenE1?=
 =?utf-8?B?TUhmL0RNV2xtMnYrbU04UVFzZHI3U2VBMG9TelZ6WmVHcmdRRUV3QnFLdnNq?=
 =?utf-8?B?Y0FRYnZiQXNVdmFEUHdOYmlQb3Fla294Y1pScnA5SjhkemN2RVlVZFZXY2V1?=
 =?utf-8?B?c2s5STIrbkkxS1k4K3dvZWlaL25nZzJyYWpFdTR5NDlEZzNCb3QzYk10OGxl?=
 =?utf-8?B?TWV6TEpXSWdUQ0Vpb0FpZXVhWkpPY2wxM0xVNXNobUtRbFpiYnFFWkFPTnBj?=
 =?utf-8?B?emNJbkRzNXNoTDRLRkVsNFBwUzgyL0Q1bG9YK0tzOG14WnhYOGlaYURhNWhj?=
 =?utf-8?B?Wm8rc0NhbnJsNCtVVXFLMkpONEVPSlJFTTNEZnFQR1Rrei93dGsxWnc0d1k2?=
 =?utf-8?B?V2tWVjg2Qy9FVkNEd0RMR1oyOHg1ZUh0cXlFR3duNlVEdDB0dno5alMrUEx2?=
 =?utf-8?B?L0ZhMGZCbEpINnBDeklybGV1UjlqTkFzTWFkbG13bmlwekdEOFg3ZFBiWC9h?=
 =?utf-8?B?aFoxcGEvVGlhZlVTUVhXUkZIR29QU1JDSGJoakNENG5FNDc2dHRsT3Nza1Uv?=
 =?utf-8?B?ZDlBTFpZNGpsWUNvank1UFJIQmozSTljNnVIb3N2Zkt6UDA5YlhsTEZUQmdQ?=
 =?utf-8?B?THhxVjNlK2tSTnZFbGFkYysydjZjMW1zeVFpVkZTdmFMa1pUOXA3NkVyUzh1?=
 =?utf-8?B?S1JrR3hMdjJ2cmFMMkdJUVJoMTd3NGtpd1hySVZ1VDZ0UllMTGlZdzdYVVhB?=
 =?utf-8?B?dnNhc1F6Q2xMTWhGcXFTbVlieVhzT0pSSjBtajI5VitZNmxKK1k4aFZkMWxn?=
 =?utf-8?B?Zys4ZEdEV3JmcnNRMXp5T0lBZHFMUm5zSnd6clN6ZGZtUFl4L1U3SnBmNGxv?=
 =?utf-8?B?Y003TGJYNlFVVVhObHNrRlV1UEZsWnNGcjI1MW9hOHpEVHYrZEE1SmhEVUJH?=
 =?utf-8?B?QlJWQUVNS1h4K1pKb0Y5VGNMTUthVm1JWVBWdkduTTlwc1FvWFluSEpNWjlF?=
 =?utf-8?B?Z3NnSG81Z3J5dFRjc1d4TGlaa1A4dVROYmEzZC81SDJubzQ3dUlWaURoSXM1?=
 =?utf-8?B?UGJFa1pFVzBOVzROWVRsY3F0M3dOeHFCc1RMUUJzd05jbTdPa0R5OGZTMEJ1?=
 =?utf-8?B?RjcxMWExUGpndHgyeVBMQXpJYkg1aVVmSHBpTW1rL05jRlpMTFNVN0Yrbm12?=
 =?utf-8?B?OWdwTlgvaUF3QUlPSFdhT1JDMldiaXNGbnZpc0ZXMVZWQis0VzlZbEtpbTZ0?=
 =?utf-8?B?bFV3S1hJMW5sdFNJYkViU0tuU24zL2FVTmRwaktzMTh0a3pEVW9aZ0VaWms4?=
 =?utf-8?B?eGpyV1hUVUhmTlpCVFRlbDR0Y1RvblZlV1Nkd1FMdnVWcnVNbHBHS0hHMW81?=
 =?utf-8?B?OGVLM2hmVGY5d1VqMjJiYmtaMlRBN281d09DYk9ZV3FFMWpzMkxyMXVieSty?=
 =?utf-8?B?M1lvQ081ZVppOVpvM0luWkVNanFZZmJhUXZDcTM1QVpFTzBtVkRJM0NUUWFG?=
 =?utf-8?B?K0ltdlM3WEtoWWVNa2l1aVh2SnhyYU1TNFJOTVliUm1iZEFmZVVXRGdFaCtm?=
 =?utf-8?B?ODJLT2ZoVEdSNk1EdWxFazZPMlE5OEg2Vittb0l5Yll1U0hSeElKYnY2eldR?=
 =?utf-8?B?L2luUnBSM2ZBVmo0VGhxWnF0UXdmNmZjc3RQeHV6VGpnN2lTOEhoeW41KzlI?=
 =?utf-8?B?cDkwL2FRcHgrYWlSUjNYZlhZUGttSkl3Mjg1TFhRZkhxU1o1SmdHT08xeXVN?=
 =?utf-8?B?ay8xZjdWKzM0WEtUSkJFV1RNbW5lbDh2MDNBTzdnVVBsakE4Nk13T2N0SDhr?=
 =?utf-8?Q?lAoNRGJDuvN0LRdWAy5p0jkPx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce8cc4c-cc6a-4851-5d39-08ddf14dea9a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:11:50.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLKO9X6Dop/7ghPGgYIgVmo/fyrwGd0YgkC9TU9uwl2arAVS/z7zcW94LidAvy86KhFJBmGjt/imZLKR0Eu5vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334

On Thu, Sep 11, 2025 at 05:42:39PM +0300, Nikolay Borisov wrote:
> 
> 
> On 8.09.25 г. 18:40 ч., Yazen Ghannam wrote:
> > Many of the checks in reset_block() are done again in the block reset
> > function. So drop the redundant checks.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> 
> > ---
> > 
> > Notes:
> >      Link:
> >      https://lore.kernel.org/r/20250825-wip-mca-updates-v5-17-865768a2eef8@amd.com
> >      v5->v6:
> >      * No change.
> >      v4->v5:
> >      * No change.
> >      v3->v4:
> >      * New in v4.
> > 
> >   arch/x86/kernel/cpu/mce/amd.c | 28 +++++++---------------------
> >   1 file changed, 7 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > index 34268940c88a..9ca4079ff342 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -812,29 +812,11 @@ static void amd_deferred_error_interrupt(void)
> >   	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
> >   }
> > -static void reset_block(struct threshold_block *block)
> > -{
> > -	struct thresh_restart tr;
> > -	u32 low = 0, high = 0;
> > -
> > -	if (!block)
> > -		return;
> > -
> > -	if (rdmsr_safe(block->address, &low, &high))
> > -		return;
> 
> 
> This is being replaced by rdmsr, I guess it's safe because the fact we are
> processing a block which has been on the bank list means it's unlikely the
> rdmsr will fault.
> 

Yes, and the MCA register space is predefined even if not all registers
are occupied/implemented/backed by hardware.

The behavior on AMD is that an unused MSR will be Read-as-Zero (RAZ)
rather than cause a #GP.

> 
> > -
> > -	if (!(high & MASK_OVERFLOW_HI))
> > -		return;
> 
> nit: However, now, if mask overflow is not set a write to the msr will be
> performed, with the effect that IntType is going to be cleared (hi &=
> ~MASK_INT_TYPE_HI; in threshold_restart_block), and MASK_COUNT_EN_HI will be
> set, that's different than the existing code, albeit it might be ok.

Yes, correct. We may have extra unnecessary writes. This would only
happen if we find a valid error to begin with. And the error is a
deferred error or a corrected error found during polling.

In effect, the register value won't be changed. The control bits will be
set the same way as during initialization.

We could add another flag and try to affect the code flow. But I don't
know that the overhead is worth it.

A lot of this set is trying to do away with extra overhead, duplicate
code, etc.

Thanks,
Yazen

