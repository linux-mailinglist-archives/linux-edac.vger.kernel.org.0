Return-Path: <linux-edac+bounces-3159-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A121A3C492
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 17:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE8617C4B3
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 16:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253131FE456;
	Wed, 19 Feb 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qu9kB1Ak"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B21FE444;
	Wed, 19 Feb 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981378; cv=fail; b=jzv7fchn/FQ7NNUTIfDCS0x5ww32Wu0OTyEOAj5RhsqdD6aEev0x/5lWYedRyElIJc04ItKMgtb/UllJckJi4WZ1MN6gbzwogqp2mkcVKAg7VQ2haZIFtKjY9CtawdO2qDnZzH7o/QpyzvzD219ySKzlqnY70+Xb3Id1w1AeUV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981378; c=relaxed/simple;
	bh=wIIV7DVH+D6qxPCDe2YghgNLs62kiqAaS6lrAgmKqAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Owcwp/raNuOd/H8vJZCfo+T60l7kenS0FqLucDjsYSgOW8vWqmy0PVQXPlEVjskEE8rHwqUWK7/1oAHJsrGim+zj/ff30G81Cs85Tsz57jAqg1suvt3yvZAAHJQWNmz65lq2hrC5xpNKGiPlK01pQp0o0C5KpgCybJOQVvIgrMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qu9kB1Ak; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiSdbTB2/4UAnJN6qRd/kk5XfODCCNZ6bb27yIv/AeUbhbnHN58v5tlCiO7mWA88Uexeo7xWB7aLw5KJQ1CLJAfmW9VUWgiiWA7z3wltgjj6Mf+YypySwEnDBY5nRhmvTiGTEnUQzUtfggF69a2DGfMw5vrxjwAsLtbB7Flx+FXrz1d7xvwLkCHTCCLFHi/5If/8IfBZw70J1+MXDRm7T5fXiQOVq5hPbyDCqSR8BSglWPYYa5X2qYhA8mnYqqmSoJ+vmqTYn6V8Hp5YexBZRW0lgR8ZH/tK+uQJ4NNxRtcIj8DM0o+xvAfDdMX34RlWgL+U2MgGc2FD3o9NcEeJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk3UWQ1mGQFQT90ILSU9VgaDgrXzpXv4QqdbbQGcK0A=;
 b=yJztIqXjwePHYtmPMrkTb579cMS1rgR7PnbM0hZqIYcY47Ve7PQlPboq7myT+iW5WBrY0Zb906uZuAanpRT/ebH8UwrBICUCCY+S489S9JixO/WHcm2xutYyIC4qbfAR4tNxnxU1W07nCUBqaqwhvuXFiDAj1xxN//tp5Js2V2NjNMsjnhM2izqXvQhFDsN/v01sOf6ZAEAOWCXvkH/KU85cTybwuovsmzdiGhb/Lh22bF3JK04l9C/2OCW2fOGfYD+JpjJJA2wUhUUBpPP2fUC+zEweErYlh5A64+cqhHVvmTmAmzXauRLKO2ezDWwbg+dLYTx+Dv4jNb+FLOudKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk3UWQ1mGQFQT90ILSU9VgaDgrXzpXv4QqdbbQGcK0A=;
 b=qu9kB1AkAcQhMW4zwZrAugTcxyyo0QJ583itWlKm7xiGePYL0OAZZ0T6f5kqYGMNs3ErjkbeA5+Vu059752qvTWivOJ+gDMUEWa6szAIFXEuYadPlPTlTsG7ePRT/iX2mRHdAh1FlYZBXDdLjloEROgaAznU9djv7CHEnrWMQx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:09:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:09:34 +0000
Date: Wed, 19 Feb 2025 11:09:30 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 13/16] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20250219160930.GF337534@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com>
 <CY8PR11MB7134EE8E03532382B8FC23F389FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134EE8E03532382B8FC23F389FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: c4098f2b-4a70-4499-a6ca-08dd50ffccbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Ko3xaMXTk/D1BDg1xGfyKqm34UDOofwvArgFRB/7veellMv/ajU30qI8wc6?=
 =?us-ascii?Q?wJ24DrYxuySEKMSDwMAAtl6YnmnpAU9qDXeTN0kzrodX7c24pYL14BIjRjjQ?=
 =?us-ascii?Q?dwsPJko5rKudCLwxt8JvlIEqO3LyQNOXlEMqtHYJx04EmpjpGZ28lZKOdPRu?=
 =?us-ascii?Q?BETgd9pdMKS5VzXMq9U3HDM+VAex4X+d/9+Jbk1CRdoFI4CQsV9P20NlsRTa?=
 =?us-ascii?Q?cppsTmV4DyHVwdlyjAtRZyvOxqIwNLx4JwogiyhA/ZRgCvVc3DAVdpKJw3gq?=
 =?us-ascii?Q?6JusUnYSWQPte5qOoe/ac9R6zHHMykDx9xhw1Hckimv9Yt70CMjP43s9RWgm?=
 =?us-ascii?Q?ByMeFyD0KxvdW/oGLJrejjQ8Roh9v8Js1bXQTG7YiH2x9yIHv0XvX2iNjqM4?=
 =?us-ascii?Q?ehQ7JqqAJIQvUDDuceP0Hx8BLCmEcOpQEklLjtBXLE03farbVZ1R0aHYpODo?=
 =?us-ascii?Q?bXliiPilP5anituKlldHKhih11LPZOgALdq2ejH/lzjyZNBqpouc4/HzvDie?=
 =?us-ascii?Q?nK1MK90BcKbuFWxHDJz3q1gXDc30xAIDHOifO7TDpecg1v4cGhG4Sxe3zYoW?=
 =?us-ascii?Q?SkIcIcK5qkvNXwk7bI68nzwl2JsFaLDh4ueVpSiGgOBoO+lXPSbzHMf1l+2t?=
 =?us-ascii?Q?IbgXNSPfsx4V2aWN1eFhkGvryuA/sEErM60tMVPA5bk8JVq8YE7ybqbINDXW?=
 =?us-ascii?Q?D+fAHW6w/tG9+ou+5AUYJfkO0810dgYMtDtr7/XmfA+2/pEwL3lficKeMxUt?=
 =?us-ascii?Q?YybONG9+HSGGYoghqOnM4tRaPA9yTt5VQCoLR6mC3PoeHwtI7mcoTiX0K+ri?=
 =?us-ascii?Q?VkvwcWojWNxeEx8k72Tel+aoij4tqTX7f65HUbR8Ne1OUgK7Wqwxmf+jY3j2?=
 =?us-ascii?Q?+pz/V3d0EAZ2rl9PpXq9DijLW1ZaZc0HWW06tsRpvwbrwkMpc2Em3lGTBDS3?=
 =?us-ascii?Q?xDQiT+PpVc1mBmDOxsvNHzw6B03JOftAXw6Jpy4SapXA4wjXVfWs1/6CuKA4?=
 =?us-ascii?Q?V5F42WE0MMkn7dX0fqoz/Kc84XLf5LDEAtlXokjNxPFTTMrijmMWnUJnHMPI?=
 =?us-ascii?Q?Uh/eIW0R0bv/GyEerTGAgf3LCS0TljgcBWDzWKWZv8o693dXV6iuQNzUTz28?=
 =?us-ascii?Q?Cab6+HydgdLjXbxjC8gYCHTvHHstkfkN4fBJyKFKxho/dAWvvQocdV3a5kkZ?=
 =?us-ascii?Q?rW1cD11+azQdWLwOhJxmO38JQ9FLAleYU8VQvSX/RL7bXxMhMgWudbqS2fAn?=
 =?us-ascii?Q?TMoVWh+T77Q98R8aFcIeyQuNn5/jBb8nBtphLpmf4QDzsHlnuUSttno6jm49?=
 =?us-ascii?Q?nALV5MqoY1zBQUj1wnAjStV70IeY8I+23Hd33SbJ8M2qTSHxtmLIk3xM7DUt?=
 =?us-ascii?Q?utAro//KRr4tYrINNwDxUFajE3/v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKGjav+nWT6EMCIlIXDKsUW/ApSlDpiVXphiP2T49jrA+WLLJsNusV3mQ38s?=
 =?us-ascii?Q?oyGNqnLKw/oM2LPE65hCedmtZZypMxp8tnSG147NcSmtY7XlHyn1824GYHmr?=
 =?us-ascii?Q?2Z0FjCRsX4qAv8I57qwdV59e9a/l1mlZ9l6jKzplKf57EiEJsA9+r2PCmeOl?=
 =?us-ascii?Q?vjJpq18jhUNhTSj6XeOD3eWvCSwzsFs0EypXGljEJHG4Uw8/7OpZKOEbcaLs?=
 =?us-ascii?Q?4p7larszY/+BX8Pvlp421TaGtHYpwpYyU73iiUjXWIv1LLDaYe3aa1wnPMt3?=
 =?us-ascii?Q?Qvx3Gi7tlk1vbdcJyZ82fVFIoRJNCAuMNVUj76e0W5dvurcz8CI2gNtCtR9/?=
 =?us-ascii?Q?TQEzN3I0kUHEppHF+NXBpQ4JlNQAwDV6D+EFsC1exWC7mgte4TyoWUOPkWIY?=
 =?us-ascii?Q?CE8LK3WfcGM0Q3YZ5EuW4bP1omMSI9p1ocxGMkS9p0c4+d7fgteekpSq26oY?=
 =?us-ascii?Q?S3tmWzhZ5lSF8yWA0YVC6bd9pnfWGnzqJ7KNFpqUwn+F7vklqTlkkNu849Sp?=
 =?us-ascii?Q?x8Hus34HqMOAcOUi41myIWCZzrOAwPqzj/qzpuYAzyLhBdQ7CoG1m+E5hjYW?=
 =?us-ascii?Q?ANB95lwZdVqWml3CCU0TPyjTwaxK+AXQ71HRsxtwpEj5KO6ls5BhapfuLWFO?=
 =?us-ascii?Q?Puf9XZbYdMOGbuebUTAkzD9lBKxPoq9lE5bHYWzsmtD8cIB+LcuKLH8FnHQh?=
 =?us-ascii?Q?TMJDBxBrkBIGVpBarQ3ecMfU/g5gSeRkDpLqJaxvtwNDkT182E/HEsSCi/Bd?=
 =?us-ascii?Q?jvNbED5H1Jyp7Ta8HF7dwrRJQCNM7BDbe2wDxwy+4cy1gob17p6vLW3qK9MM?=
 =?us-ascii?Q?jwAaEXPBmcucNvGKTxa60lk1TyP094dmC5QvFM0vgwBTdwIP7xJaK9xp0SEs?=
 =?us-ascii?Q?3nZ3dGoH+LgyCjIAY7dQsoVyinVntnYv2EeLJ6cZprybX7tUW+t7f2CoQh4S?=
 =?us-ascii?Q?6x6i/U6ipRDBXIMs3QFEwpICFC1ULpUpSThgIdqiXq9gniq+2uu8GOClaY8j?=
 =?us-ascii?Q?d0afE7Ep7mZNyRnyMb/yLk5nEKE0ZLm59Ofe/hU1bxIjeDqy72t/I7xsvBJP?=
 =?us-ascii?Q?x8pS1SdI6d3NCkP0PXIdPXJq3zfAmncLbZDm1vJNrP5gvN0w9HzJSfU61sQw?=
 =?us-ascii?Q?ENeNimqODLD0c3j/0vFEJpJZSnb5H62apZKXCRl45ZGSLmbhG1N5OJl0Qxth?=
 =?us-ascii?Q?IeSl9N04atLCF8Q6s+qUxomTYi3G5LlvtmYC43pkZ/Tv3kJ9Vfq1rnpDQp9y?=
 =?us-ascii?Q?IpmFdyQSI6X9IHtfHFPratFWJd29QkO9ulMRzDGIo/I33R5IEugLqxyW3Jeq?=
 =?us-ascii?Q?yoqgex4ps1267Tqs0Cwx5W/KlYR9BHQzrUj0rsGJF0sE+NzIBSKPzw+1T0U+?=
 =?us-ascii?Q?GHx3s39PfshoAOUSfIGFjh0OKD2+15Guq+hthRHAHU5dL6Ohe8GGkNYY4LvD?=
 =?us-ascii?Q?AxJMsvOPFz2/Hc44v8X/oWTjJQYuewHptJ4FxWFiaAttfszg/BuD1GWWEAiX?=
 =?us-ascii?Q?A3Zn455+XBEzXEMeZd32gK2Z7Mock02AggIvC3zoSSlYErN4/3hJclDuH3CV?=
 =?us-ascii?Q?U4UtE/BSHOYB/p3ht/RLItJAM7IXwYHdGJEAXo2d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4098f2b-4a70-4499-a6ca-08dd50ffccbe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:09:33.9786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PF/4zmYO2QdNLosvqpgeDXjZC5aeE6Qtw/NVm1SY+92xUnj6ZkYEhHMWkoUjD4gzaRJ0rrZZI6SYOKZH7VSLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384

On Tue, Feb 18, 2025 at 07:37:18AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > +static bool smca_should_log_poll_error(enum mcp_flags flags, struct
> > +mce_hw_err *err) {
> > +	struct mce *m = &err->m;
> > +
> > +	/*
> > +	 * If this is a deferred error found in MCA_STATUS, then clear
> > +	 * the redundant data from the MCA_DESTAT register.
> > +	 */
> > +	if (m->status & MCI_STATUS_VAL) {
> > +		if (m->status & MCI_STATUS_DEFERRED)
> > +			mce_wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m-
> > >bank), 0);
> > +
> > +		return true;
> > +	}
> > +
> > +	/*
> > +	 * If the MCA_DESTAT register has valid data, then use
> > +	 * it as the status register.
> > +	 */
> > +	m->status = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m-
> > >bank));
> > +
> > +	if (!(m->status & MCI_STATUS_VAL))
> > +		return false;
> > +
> > +	/*
> > +	 * Gather all relevant data now and log the record before clearing
> > +	 * the deferred status register. This avoids needing to go back to
> > +	 * the polling function for these actions.
> > +	 */
> > +	mce_read_aux(err, m->bank);
> > +
> > +	if (m->status & MCI_STATUS_ADDRV)
> > +		m->addr =
> > mce_rdmsrl(MSR_AMD64_SMCA_MCx_DEADDR(m->bank));
> > +
> > +	smca_extract_err_addr(m);
> > +	m->severity = mce_severity(m, NULL, NULL, false);
> > +
> 
> Is the following check in machine_check_poll() needed before 
> queuing/logging AMD's deferred error?
> 
>        if (mca_cfg.dont_log_ce && !mce_usable_address(m))
>              //Just clear MCA_STATUS, but not queue/log errors.
> 

Good question. Deferred errors are uncorrectable errors that don't need
immediate action. They are not correctable errors, so the 'dont_log_ce'
flag shouldn't apply.

Thanks,
Yazen

