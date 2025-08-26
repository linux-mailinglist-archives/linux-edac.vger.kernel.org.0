Return-Path: <linux-edac+bounces-4689-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FF8B366C1
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 16:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E978E5705
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513835085E;
	Tue, 26 Aug 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1tF4yNMn"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557A34A315;
	Tue, 26 Aug 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216085; cv=fail; b=NkNeD0gcrocTkH2itg8e3MumriTa1GbQLWxTj+oNnT7HjcTtEVmziPcux6l8qrBGLooGFdSjlsFnFBqFPXbm46dSaV885eXqkuAdJS/GXov2CFehWcR7IgEn30gouw4h5LZz8UUfP/4zVlKgY5fk5WkjvLOHV1Ctwh/f4+cgDXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216085; c=relaxed/simple;
	bh=eOJC4iBaZtcEOxxPctvtVMA6junD+7hHDJCly7hueXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pD1S2LeueOtWpA408lcxsTcuuMeRLoA3zCmsbu0a+GWzLbC5iDshjOhdhqUbSO0VIhcQ5g5fUa/hkDzRYHBq4ZEVQCWHAQRmqmcHk6lbfPuQyK6QKuglAGGBDLmCsiKSelMjRtqk9ky6aeEaxU6s4JfyZe4M4d9QGWKUY4fzDXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1tF4yNMn; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1aifDdyV4Af5LqTmiYhk1w783lL+lpjhKxguXckc/UraYeDtKTCr8KVPHPf5BkdZ3eaJZ9KGXG9bezvObl8sR56mCIJQiK3SPrnAaKRNkQBNf6WM28JEtpzVitUt2fm7qQ+ejkWK+K0HB76kYjUwIdZkuQZvG+HARRybYXJNWZRSm48iXitz+CbhN7M9XIhkks+keb6g2d0GGK8uXvn8Mtw1PMf4WLt9RVOjybaqJyxqL190e0DzW027pkc35ug1XRM2/eFQqnUJqvym4SUIzlsvvlBCv+TrvSweVTYpJRCy5AnuasraubLhvN4kKQb5wWoKRW30LkHGF4/HecNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLqJfxHFxiHVifDAABP+QmLtwlLQeYTSHNUVTyzAH50=;
 b=tuBXLCm1n/zIGBUPQr8+WOga0tYH/yRkVr2TyXzqpsCmGOudHQFTT9ZW3qU8ykmgSxDgWxzQ4kW162PNg+2D3tFczib88j04PYDw25BibAjvHbQPGQS5ATfb8iSr3HZBQrYeCds1EIXkti7mjWWzKLpMk3vC7Vf5bwqL1hB7Sfdd38VKFShUml3Oj1lBg9Vij84bEftDh9MNBYO8cnd0orO31MjBHDnnVdsuib2bb0/zeSFAnce5w0I6tQJm5UhKEPrAsBJoguWfb9QoOAULulaOZIvfvXp+Jzsmpt3qqG8avehKiq0GVIDJuB77d34tj28mMIdFQStfJ82iUTDjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLqJfxHFxiHVifDAABP+QmLtwlLQeYTSHNUVTyzAH50=;
 b=1tF4yNMn6rn49xQDisX/n83z5oBZ7NafqJsvYsjRjH2hOZrkMNKMZRo5L7G7uySvNVmCzxYqZ65d2ZOukx0kvdBA/YF6Towpyn9Iw3V9+TvOglDebcbaBzdJYGc+krkGZQhA9//TEJuF0ZuWIV9W6YggKRClB48Wbbqtqyt5/iU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 13:47:59 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9052.017; Tue, 26 Aug 2025
 13:47:59 +0000
Date: Tue, 26 Aug 2025 09:47:54 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 05/20] x86/mce: Cleanup bank processing on init
Message-ID: <20250826134754.GA337914@yaz-khff2.amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-5-865768a2eef8@amd.com>
 <20250826123503.GEaK2p9-e87SaTMKVv@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826123503.GEaK2p9-e87SaTMKVv@fat_crate.local>
X-ClientProxiedBy: BL1PR13CA0395.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::10) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 026a9fd8-e37a-4a3a-b899-08dde4a72b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jUNg2TVs7OZ02fYkBZJBmRE8JEoT5031ceVA7qKdtPMQrbcQxk/vK2pbdw5A?=
 =?us-ascii?Q?qasKFsCjbVbhmeTK5QgNm/VAAJACXiwTAVsrzpF2yfsbVgjSAirRR3Pg8QnM?=
 =?us-ascii?Q?Q/HIBawsKbMlyamVC2CEYGjpOzaxMEOv4l6wHGazZLE1q1Ie13l/iCP3a7Qr?=
 =?us-ascii?Q?KB1avhi2N2+Ykn4rmzhNq28+WQatdNF58Fj/3NmT1/MilgMpVxpTKutA+PSk?=
 =?us-ascii?Q?c705/btDlHenDGm9T/tqswtFrWGcAJPwffJCMmzimCUorkRRJuP7Yd4CEPqg?=
 =?us-ascii?Q?eJEs6PTg0dHbJlfIQA9e9HY7Fk7BLVqskblQI5T8SugIH6tnVJH8j4GAbwoc?=
 =?us-ascii?Q?0Lq2qYrRgtykJ/vCIkGKuTVifqnj5vl5/IuExETZIT5wbCfprgq73MOWlKhL?=
 =?us-ascii?Q?WaMsrPxLJC1gDrPOYbz7tkXmj5aKy9LQ2L9+7wQNxLxzG3WET6ea+7APx/Tl?=
 =?us-ascii?Q?TXIkh1VlDC0OB4DeAI8XOiIzwonWhLNScBICOkKDJFNpJOn+5SLdf6SD2vRA?=
 =?us-ascii?Q?2SG5D+vPy/mnki46UxZoaGtDjto9RXkLLI7yRFEQ76bWwjlAsjXE80SmRlMH?=
 =?us-ascii?Q?/1hqQoTyhnv8xnyH/27jPOAlmn1LDd1spQoIy3OEWEUC7v7lHoqma4dsfGxk?=
 =?us-ascii?Q?duoAlCVBn1MZHkwdaUvLUd+Ci9Z+WHXwtajzzVi3rXbrtNZqKHyy9pcVZOaE?=
 =?us-ascii?Q?Ycgcb/94NaHq7v0p09jeJLFIMJtx6oDxlWVNeLc2zXaobg9g7dazNhwOIWwO?=
 =?us-ascii?Q?tTySwx8xyzIMQlr1rFl4brsGYqlQ4nHGe387xR/xwN+gXI2hxseuL2dNUGTd?=
 =?us-ascii?Q?NAtJSPcadFU09gl40hKhfDnFpNyXUquXon2tyMKgATmdlAKOi7s4WhEryIGm?=
 =?us-ascii?Q?mGgZRuD2BFnD+LvLuie3WPmaIBq56LvNvbR8wGTgBWRwdr4qYpryhtY3VJS0?=
 =?us-ascii?Q?e19A53laHKN0zLDldtCWMv2bSCbYYrvg+Kdc+YGO7r7pR+u6e8TnnUB27/Rx?=
 =?us-ascii?Q?8cMS6qHusWngaBZ8uoWkqMKK78r81Bq20YVjvdYltz+/dm2VEGV6RfXCHJxq?=
 =?us-ascii?Q?DhQCyJqa9k7eJUksq7g1QEhbwc1Txrt09UPJsTacTiUyhfmBeUJSOyhXuxCG?=
 =?us-ascii?Q?ubHYiqldRpXmNgPPDed5TKisi5H3pnBg31rfvm1GC7kjEu8V+QPcZQiw9p1M?=
 =?us-ascii?Q?nW+wcz6qvlCkhK4xbMWp8kSR+E9ePf2hRR4ksrJHpLt+n1ldq5FlbSdYCLNq?=
 =?us-ascii?Q?fZCZJaPe0JH4p2MclAGsL29qcNhjjtuc6NEwq7ouBjCNpTqDL3NrnBUZYaVH?=
 =?us-ascii?Q?mzRDoBRiZlFDouWYORGTyLrjfwB2FPBTP7zBDTgW+z26W6vw601OTf5bl9HS?=
 =?us-ascii?Q?dLfElyCeKD2XZJcePSAfzR/LzP16KApe119gvhHIAQX1NyQSEDY6NncVqxpe?=
 =?us-ascii?Q?dFhDvoB6mEA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iRm6xM6Zlfim16dxPA2cRCugjcwE6fPaEDtXEONfjS36riTSTazBd7aITmE9?=
 =?us-ascii?Q?WkD2ooBXFYKnKqTkvtlDlQk3ixAWvSr3ko4zUW8Qnb5o2EKxkfZkbbWKG7tG?=
 =?us-ascii?Q?nXIJ+q94LFLYdFEl1S6zywgir/9VmURQIXze1AvNUSCX0bkZpzltpeP5HFLS?=
 =?us-ascii?Q?ECEzlOMymg0aQfHFgg9R3ax54bm7agPhhhQe35Q2jaaV6GXHRALC9Y/D4CP0?=
 =?us-ascii?Q?CEqm6zWEz1hE7zmfD3lHjsmxiGm27U5q7LYAvi4hnUn+My/ue3ec2Mc+KhpR?=
 =?us-ascii?Q?JVj3J7zQQpuhXZSj5HYyGdydWD0tCvw6p3en6folmNRHntYgbPRerL7k+FE5?=
 =?us-ascii?Q?WyiDXQaZ4A0slGmEqf68Zz4QvkL56Gwz4/PBdwkpqKTVV2TyAEK/Ra0OE2DF?=
 =?us-ascii?Q?MVYf073BjOVydimZzXgh2MMtlmfvxAD9MbtSXHwt4+4jlqhIyD+foki4nU3Y?=
 =?us-ascii?Q?TahBsryt/MkdoOTPEdQNFXeku17S54ozF+SfjUo66oCz5rCuKInbTxa0slKi?=
 =?us-ascii?Q?GWd9yJil9rkFQLzB4EfzjvwRaqmH/kvsVg/0JtESBq030geKmQe1bmKmvcko?=
 =?us-ascii?Q?FqVo6Xm7dqV7resHXewPNc6I1jxXahU2xiprpVRuYmU53SHUOupRFffDbhBT?=
 =?us-ascii?Q?sv7HR1A++T+xhs+PXuv89qorCU5/yGLrz7G+AZtni9QmXe5uiQM3zcrdvrc0?=
 =?us-ascii?Q?lKtFwegmGk1AsDFj0Vu+yMjVt9FuPnmOkNGevbKS0NNBFok2q9vhL8JXwuIG?=
 =?us-ascii?Q?ohPNaKd/ngkU+hh84rJFT9U3TNTWEW9QoIjvVXwaGgYAo4/xysbPj0vmt7aQ?=
 =?us-ascii?Q?CiHmrBY8/fXfe+1XQ6+2f0kCmFUnu69ThQ2NdkmhfXC1l8DHQ88QAjgi7WVF?=
 =?us-ascii?Q?Crb4Xhnjb+2dVmH35O5u1P4CZTbBa2329N9vbnxGHVuag5l/0Qt732AMKz1P?=
 =?us-ascii?Q?2MviICmfVxUL9uC76ScI+M/iJs4sRqXW6nS51UMqnp8b6KOuGVs4NYckzCda?=
 =?us-ascii?Q?37I/IkCdANAWuw8Tw/DbzdDfc6uNn6vzbQbs0mcfk9ENJVL2rkokFM/M4cid?=
 =?us-ascii?Q?7GQG5sOODJxsdAfXfXGmFZUaxVAfJmJPQ/8qva97xenoM+WmCtil9z75Leac?=
 =?us-ascii?Q?hHPZ2EU7g6lQu+PWAsmlacIAfPqFSUMiuHifAoZpxvgeZl8/5G3V1MRiwnp2?=
 =?us-ascii?Q?fQa/jVDaTbiROohl/pRqSR3rQdI1DGoxgegMNTrHgNsqxVDWjQ9sKqXSFH8n?=
 =?us-ascii?Q?OzOztaAGnIJ9vPZR4bexZrW6WyD16mTLWZzUueMQgxSkXgHrbetbCuT+ynsk?=
 =?us-ascii?Q?NI8SOBO0Ye7I3RZAy1PoW40FyfUysXNvOpQLIn2t6t6wREQR8pX1k8BQt0Ik?=
 =?us-ascii?Q?+tX/8yZ6t9roM1bH8F9Yly4F+LXtf2KlBaLo3cCe2pWs/A6fF2JUej/jC3ec?=
 =?us-ascii?Q?q9O2QoN5Hz9TFgfWp+X/2zfnyp9XcEVY6bltxEzbOk5M83ySIYnsunaR8Xij?=
 =?us-ascii?Q?qi83ZWWaQwRqtv7HrVxwY9RkLxieZIrffi8ahcGYvdrmVRT3n3UCPMKMP+rI?=
 =?us-ascii?Q?WDqW3dYesv0DHU3tbjI5HWBYBRi+HPTryrpXMgO+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026a9fd8-e37a-4a3a-b899-08dde4a72b19
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 13:47:59.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWdQX0+cyG5RRSVABLFEZ54Ws40AxMCzRcD1m/02QtDM9K4U8SwLJ6NovHyKsAeuuUJqdDjKszJYg5A5/aRUjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

On Tue, Aug 26, 2025 at 02:35:03PM +0200, Borislav Petkov wrote:
> On Mon, Aug 25, 2025 at 05:33:02PM +0000, Yazen Ghannam wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename
> > that function to what it does now - prepares banks. Do this so that
> > generic and vendor banks init goes first so that settings done during
> > that init can take effect before the first bank polling takes place.
> > 
> > Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks()
> > as it already loops over the banks.
> > 
> > The MCP_DONTLOG flag is no longer needed, since the MCA polling function
> > is now called only if boot-time logging should be done.
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> 
> Yeah, when you send someone else's patch, you need to add your SOB underneath.
> I'll add it now.

Thanks. Sorry I didn't think of it that way, since it was posted to the
mailing list and I was just including it. I was thinking SOB was for
submitting on another person's behalf.

But I see how any inclusion counts:
"Any further SoBs (Signed-off-by:'s) following the author's SoB are from
people handling and transporting the patch..."

Thanks again.

-Yazen

