Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC43CEF7B
	for <lists+linux-edac@lfdr.de>; Tue, 20 Jul 2021 00:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbhGSWPp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Jul 2021 18:15:45 -0400
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:7520
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1387612AbhGSUZf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Jul 2021 16:25:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFV4jKJ4usLfLm6P72oNQFOx0nVbJotkzjBGoZ9HrmQgdJQaDvnxWOWG22ljPZZud4HYKwhflL3zwHpOwf5FmsJ3muHuLtLyar1D4dXizEZwXhSnJmtTCiJKNGfaDnXwyuzyb7ISnHHobFypCyCslxz9klqKj6glsKgBs9v7nGC+hbhRPlbrn2ahHwrGYkB8tC8+d7w/42eVMqXsEH4KKxc0poPsxbYATGXst/h++9KRO3dE6nJxOhspsBKKqcWdYhYBtg+rQ211pQsbLAdtupxrsB86wXtS0aY6kkgIYZ1JornE2U5DotD9ZIjKNzOGu/F7T0sxdj/A+N+GI6J5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zfm8zw3uIfG9RNcACb7IYgVp419b+9ePKBc9XPRyGA=;
 b=NTLAFIjnTu5eM6KKqJ+QjTNrFlG/zlBR+5bn++XcagyAVnjf0aX39kxESKZg0LmKZFFCzFVN7v0x6AHkrTdWc/5EurP+yjkRODmJC6uHKfb2wbVQypyrOUPyq5h6l9CMRONADhfPT4WJ+jdTnZaXmHbVNe5wLUAqXub2DP9Vrrf8oEgbF/vAuX4ok7fOzEyiJxwJLRKXZPczrt+VxL9N0h0G2KzZwICBSYwfZMIVj0RqqVviWp404uii4MGfoC3kZEBSAKO3Xo192ri8PDdboknHkedsBJDEGmetVOrj0+SHF5OelwVsUuqnOPS1gHnnX5RrKW2rLuFcr/RUvq+KGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zfm8zw3uIfG9RNcACb7IYgVp419b+9ePKBc9XPRyGA=;
 b=mCoqXVoBEn3OQ8YyWfM72zJcVQUyhdnIPS2C7Lb/83yvKbDEIRij18U1/H8iZYruTT0VWa5omDWD0zhfc1zdTiZ2xqpBqBC5ZRTDVCUvBaHibkvc6yyzPfIyWdtaLvjiWlEI8BD27ITo/BpRI0gAYGbw6icYFDR8yX9mPYOorFo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Mon, 19 Jul
 2021 20:48:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 20:48:02 +0000
Date:   Mon, 19 Jul 2021 16:47:58 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: Re: [PATCH 3/7] EDAC/mc: Add new HBM2 memory type
Message-ID: <20210719204758.GC19451@aus-x-yghannam.amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-4-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630152828.162659-4-nchatrad@amd.com>
X-ClientProxiedBy: BN6PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:404:11::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR13CA0056.namprd13.prod.outlook.com (2603:10b6:404:11::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend Transport; Mon, 19 Jul 2021 20:48:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48f93578-91a5-4e57-57d9-08d94af67fc7
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29792369C8BD8A411E0DCF4BF8E19@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkvVqKD1idAYlksKrCVCrzT1X/YGN/Mz0REDu2LuhhqW8fZm1XbJI0WEjwm7DZj7huA87zOY/6XJDAyWJttn5YUab2VDYjGBDh+9EDug5CbR6wYTVl23YAwwmdSXqQUHusWnm2Abrux0PS++75y3UKkMZe1oQ18jMhq7aiqHxykHVqLV/QlTKLDp+5c9CGWlJgCR59LuELFgBmmxaA8a+HixQEvoUdggHqCmXrXZ60OpbxGzKE1OKDpkyaYf2cxwM8akelEKdVA7diSOyLAnjmv/fsQr9gQLP+kTHh59vQ0oJOQM4t4bDSbVf/LRXZzeJ3sduxxqXOT8q5zdccXGMiYta1RP1gtd7NbdqJR+75BHor4o+ByXpfXmSFRL/ILkK1qeZj9PzFeuUjUjvVzWDIFB6gwMTOi6/PMvx5fiW94FMvTrnxlss2Vu8WyM9E6ZXJqEWfgTUKrY3dmDd0F6OV7ZfjTZ1YYUxYyy1isGaB2kY5+QVnlWJDVR5gGQ3MdYr1sEfHY2YrJ0QidQqRM6Yg84tto0clq7plthFoXSe7KrQLqnFDz8N/70MdPqBx185eXDsCpQ1ij4m9iSvcv92enLPpycQjgf6DMWp48ptlz9P0um6Gez+4m7sWgMtvT2RmKroyfCfgzvc+Xun/Uf1hOostOMybM8CeQl2SbkLDDxi3CyeTYAK/T6v6/lUBMTxc9uoGAtuwlL/A2YKOBpPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(478600001)(4326008)(33656002)(66946007)(2906002)(44832011)(1076003)(66556008)(8936002)(38350700002)(52116002)(66476007)(38100700002)(83380400001)(7696005)(956004)(316002)(110136005)(8676002)(5660300002)(186003)(86362001)(26005)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3VefWqurEYGWIqBzvUYrB8XRIl2xRIo3GQ2KDewtutmPbituZq3rqmgjpcnU?=
 =?us-ascii?Q?9TV6iyO5ZU8FHSE2IWhZkOnXyiPjc9GtdkOo1JVFCU7twvOIxBmEKOz66Fes?=
 =?us-ascii?Q?EJf5pvnM19PZXD4iwNTRXuDHOQ4k8rXQw+V0H/iu9wG0mYAjG060PsPE0oM0?=
 =?us-ascii?Q?3A1YLOo0YXk+HKovaOeG+2uNZK1XbhM/sCSpNSeunWMffrr1iVM68ydQkrgs?=
 =?us-ascii?Q?pciHYPMPb+Y0RvzZ3pycjCol+s4RLRjNn9ttkdmyZX1PBm4a5gIyrRIf/dc6?=
 =?us-ascii?Q?axPkF2sUdJB41GznccRIr9TL9IHuvEIlJe3kDrFypkgssz39I0a4PkFqZ3HY?=
 =?us-ascii?Q?Awb+7U+w/0YlrJ6w5lqHBYREuKczwOQf5hvygggBizRAemGwmj4YrOgWGpPD?=
 =?us-ascii?Q?8J/rlm/wvtS9Edik3T/S3FEwgtc4hg4wzwg0kFFvDjOlpqz9fNxwQQneIeZu?=
 =?us-ascii?Q?p26gNq24p0gh8hRcMmuGjO1T6hqhimAhB3pp7gZzM1Q4aaXl8g/MKkrpnxIr?=
 =?us-ascii?Q?yDp4s8aRj3Eo6xmVUh56/6suvzqS6Ek2Tgs+DRj0yo5y6Bm0u3db1cbhSRMN?=
 =?us-ascii?Q?yMQqWuDYY8ilGnM7nVHrGoArhslZhcwqCvEV/DJMbwx4Sbm/DWGNJ4JSVzTj?=
 =?us-ascii?Q?h1krD1tm6YB/g5otGznudXv5i4hHbIIur80Q2mlv4YGEquUt5HjM6bYuU3b/?=
 =?us-ascii?Q?NtXvW/wDpu4CHMyPgdREcc5I8amlsfDimxZHl3kSR/jDNU9QgYBWJ2Vr0dIs?=
 =?us-ascii?Q?uvgrBOnIHy70KtG3wBgJAC+/twSFyAFa+7m0Z52zpZAD64zE497Sq1YEI+mT?=
 =?us-ascii?Q?sDizXTgoenvE5UcmkFmoLPv5DZzFlMJVlSVHADv8kp/RAT5Qm56CK/LicDAO?=
 =?us-ascii?Q?VwWwdKTm8EF85rAkecWQ8B6TuwVVZo3X7HetS4okyGtpgnclBcPrfrMGeS51?=
 =?us-ascii?Q?649jKx7NhJHnKtSCTGNQvVgWjQGSCfDY1nSMstr9RkBvN7mIdiMvThhW09uq?=
 =?us-ascii?Q?iiigNJDwl2RCJa6uD7IpWK+VAi8MEUNrup5cfaiqON2yVcxk4XCi6Mh4Uo1O?=
 =?us-ascii?Q?cuuBhSiMs3Esq7XijqCjcjKRa8UMhSsichQVD4GBAeIQI0OUn+WjC1xBFD6H?=
 =?us-ascii?Q?VuSF3kkQ5cdlEOlwXRuHr7Hb2sA97gUM0zfdBCPSXsHCDk6majKl3CGB8SOL?=
 =?us-ascii?Q?JQalNMsBslvb3NstxJoofBYYbrzHl7Svz0wlU/C790DMHMoAUrkgQmG6d4H5?=
 =?us-ascii?Q?XKXyBMFUjy8EIuWOBY1WLMjb7GcN5rwA8drjbDHEDvuvPJoSZTBle7cK6Re8?=
 =?us-ascii?Q?V7nUfYO7VutcXmlZVgAzeXe8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f93578-91a5-4e57-57d9-08d94af67fc7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 20:48:01.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfFwu/tRswMtcMaxKbwzb/Gqkc8shL6HXPM+I1tOc5T67zNqeC5o3o2h7E2qUD+dn+xutCZiebXusZ+crTQJKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 08:58:24PM +0530, Naveen Krishna Chatradhi wrote:
> Add a new entry to 'enum mem_type' and a new string to 'edac_mem_types[]'
> for HBM2 (High Bandwidth Memory Gen 2) new memory type.
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
>  drivers/edac/edac_mc.c | 1 +
>  include/linux/edac.h   | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index f6d462d0be2d..2c5975674723 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -166,6 +166,7 @@ const char * const edac_mem_types[] = {
>  	[MEM_DDR5]	= "Unbuffered-DDR5",
>  	[MEM_NVDIMM]	= "Non-volatile-RAM",
>  	[MEM_WIO2]	= "Wide-IO-2",
> +	[MEM_HBM2]	= "High-bandwidth-memory-Gen2",
>  };
>  EXPORT_SYMBOL_GPL(edac_mem_types);
>  
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 76d3562d3006..4207d06996a4 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -184,6 +184,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
>   * @MEM_DDR5:		Unbuffered DDR5 RAM
>   * @MEM_NVDIMM:		Non-volatile RAM
>   * @MEM_WIO2:		Wide I/O 2.
> + * @MEM_HBM2:		High bandwidth Memory Gen 2.
>   */
>  enum mem_type {
>  	MEM_EMPTY = 0,
> @@ -212,6 +213,7 @@ enum mem_type {
>  	MEM_DDR5,
>  	MEM_NVDIMM,
>  	MEM_WIO2,
> +	MEM_HBM2,
>  };
>  
>  #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
> @@ -239,6 +241,7 @@ enum mem_type {
>  #define MEM_FLAG_DDR5           BIT(MEM_DDR5)
>  #define MEM_FLAG_NVDIMM         BIT(MEM_NVDIMM)
>  #define MEM_FLAG_WIO2		BIT(MEM_WIO2)
> +#define MEM_FLAG_HBM2		BIT(MEM_HBM2)
>  
>  /**
>   * enum edac_type - Error Detection and Correction capabilities and mode
> -- 

Looks okay to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Tony,
The following commit added HBM support to some Intel EDAC code.

  c945088384d0 EDAC/i10nm: Add support for high bandwidth memory

But it didn't include a new mem_type for HBM. Should it have?

I only see some edac_mem_types use in sysfs and some debug messages. So
I'm curious if users find this information useful.

Thanks,
Yazen
