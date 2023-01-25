Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCCB67BFFA
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jan 2023 23:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAYWfE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 Jan 2023 17:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAYWfD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 25 Jan 2023 17:35:03 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33BB5A826;
        Wed, 25 Jan 2023 14:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674686102; x=1706222102;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jviVyKeyDwQyFZz+LlTMgpSWagNrofCnothU8XE542g=;
  b=i7e9esklFOHe4uTRLRqZjfLEfjDJRVHvlU0vlHFig9yZZ4OZMC/9NFnJ
   KUEXdDx4RDMjdinqf0SpiRINvmPSNyxtO/bg54UXklfQNaMv3ITfldrWN
   zOw/sIDJHUlsiFRxbBoT5ZWwRYuRMWNPxsCxGETByuakEWNXaQs36PKgb
   43nRp7006Jgcw5RisBqsuErmoKgK9NNwA7VWGx9/RfNeIqTB0wRUVOp9v
   zZxVUzNKpNTG+ix+p8S8GAXfjePnYunRiTZO3c/EyOEiOOd/ZKVvh9CSD
   bmlTKgASnjlTDA7kck/wKvluAzrtjqmSu435XMGhZm7QcELK4f7vrd2f7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="389038567"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="389038567"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:34:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="786602977"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="786602977"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2023 14:34:58 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 14:34:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 14:34:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 14:34:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOXShjwdwRPhXj5wDsQSZ1mfTOLYirq6XZ5r2HsrTzuoiHbyn0f05IV8wg0/FyInbO51wu8dQll+uUsvpx05or6Xdj7TIrZS13qzI25CN5Vyun/i2CaU9irzO7tVL9CBo9zlI3mSfNKs1FzGzE+jEM8eKYeV6Bo4GeCoCY6EFeHCIe3F/kEhIeLPd/dfwa41ZOl+viVzGmjFq4hgafR5FjDcgosfq4pbr2SuctjoWWwNcaFMVYqe2o1w8xGZtC62nTTHaFxrrbdeythxEG5o37pccrs48HkL0Ld2dQpcmzHXgXusgUl+K7iec1XtCZHWKUtEVKHE2eCIsfJ8QxGaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85si054GwEHOpv+PwIO4IqoQvvFp1b7R35oIf6VBMEA=;
 b=k71fsIUuYNpseXOtYWsBIsKXltecx2z6DpyfQ8c3nEaWWUg4m+M7atGuHN7pb237ZTMjPVy8PeiEezRRjVo9kMbOwQAslqN3XHsa2sUndV5wmy8VrilIClYc0A4+taOcAy2tTlDzJ5pFXnlmqvMqKzLV64lBJc0Z8GEUG+SUtZt9plj/KBoafRNjwuO5YGRzrkkI/ocJZGj+2GVvWwPO4dHj8YUqQeGdrV2Niqf0vxdOF2hRwa/a445itCiH5NRu6oym8f6XurxskuwxfwcCyhVANjDlf556xv6RnpOdtBJLHgzHHryyLju4weQjNCbg1ubZuZQ9hsxGxBbpUdiwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ1PR11MB6106.namprd11.prod.outlook.com (2603:10b6:a03:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 22:34:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Wed, 25 Jan 2023
 22:34:56 +0000
Date:   Wed, 25 Jan 2023 14:34:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     <shiju.jose@huawei.com>, <linux-edac@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <mchehab@kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: Re: [PATCH V2 2/4] rasdaemon: Add support for the CXL poison events
Message-ID: <63d1ae8d41b2b_3e042294ab@iweiny-mobl.notmuch>
References: <20230124165733.1452-1-shiju.jose@huawei.com>
 <20230124165733.1452-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230124165733.1452-3-shiju.jose@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ1PR11MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f108f46-857d-4f11-399e-08daff24625e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ovp7xCvQg1coYKHtHUUPO7mLOvIbnpX5NdRmRLsXIskIj1PnAr4AoWfslS+bT+enycbALOzyyE2DbXuhfm6qH1xqgiVbgKZkSSKFCUr432OqzmXJD9J9zhs7P1OfiAE1o6hc1kbcXWMFOAmPmE8ti8qDosjW8xBSZKfUQqAYcefwKuWxQPWVZpRNzZp4otlCt/1m8srL0Nec1NpOHgvMzdzvkLObCnzZbh4YnVTOojeo59SrUWm5Z/+995bJVvKl+a9Wz1CvOg+8lg0qy5vH31bFsSgXhwihwknARchwqNggFNJqSe0UQzpQ1zD2S6j6Gy+0i7K6/ifRrR9L0P/8N+Hcq4sejO5Hb3wIv+CT5NC7isOJDAmre2ww5Mlv9ISsrJkmxWRlL+YdkcKLYdQfqV/2eieHBCdfetaZjB0+TTRj4cDraJR263u2qZ86dkPAToMGS3YOukq5i39JtIsfGexchj2dPynXVD6BxjJUwMW92WG1q0SdbPn0zdn024mkYZg4Yu7r/n1Jmuyn7TZVkzY5vNxMFZzV9U1102vfbrPK+Sw9QOavO3Sl0QAPeNG5jnM74b/dKqncVuQXN+jnfjDFlJmYMKfmSihrqvT5Av0xD+0iiP0iY+9Ra6KwVZuHKs3eSoTWBkP7mSCMet74dXWKA1zdhy+/8GAJn/G1JwHYR1ZGvwFPNv1+9H4s+qE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(6666004)(478600001)(966005)(6486002)(86362001)(6506007)(9686003)(316002)(26005)(6512007)(186003)(8676002)(4326008)(66556008)(66946007)(66476007)(38100700002)(8936002)(41300700001)(44832011)(83380400001)(5660300002)(82960400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e2BN1RkMhoVQWRJz6lTPQpQyA3UuDAimogkh+YaVedooMXoJPJqrZPYou5mb?=
 =?us-ascii?Q?WMDSLbrvoQYndgCtNkXSL0xzOTF8bdrbsHBbVzm2vAiw0rfJNc37pidsKCpr?=
 =?us-ascii?Q?wSAY5oGYv+siR3PGNXYmtK81fDh+0bSnRH77smEHMHqFOkc3I4e0e6Z2/qif?=
 =?us-ascii?Q?Wogl1r3GRlg+a89KvRBS6/GPyg75N0E4VLluvGOjHh8oh7uGeCLssFpJWblU?=
 =?us-ascii?Q?pq66b80rCMR/6zxRXt1Fwfh4eKa3W/dI/hGwaVdL7E/h6DC/2Nkn3STImRmB?=
 =?us-ascii?Q?bKeV+MaM/bIk5P6Jf3uVCi9UvK+kz6b8tq5SYDaJ8TDU/RJnmf+PRsBfJbOh?=
 =?us-ascii?Q?3wHYPq3ANRrEGuIPfZeNrZryaqfbHdHY311AImjzP3p+Ce7ckjOjL6gBTEBb?=
 =?us-ascii?Q?9gGT6iqpaOobhWjntjk/0vUVO0wCxJGlbqv5apyIoHx0RFCkB6aZ5iV1YyZJ?=
 =?us-ascii?Q?gQJsT8mn2w0U+nqp0gnb9CVA/cAMd/I7qPgUT4zFdu21GuJbH836YLk+CKfx?=
 =?us-ascii?Q?kGUTOyrE3DbHGPSdzXPw8gSBhH+Jw/XCN1iTvmNPh1Drz0bb+srMIN/7OrH5?=
 =?us-ascii?Q?6f65wjXc7xiiJNnhtIqoMljIBgWxa6cekcrXSBWz4vjFFgiKdzIyUVgH7Gq8?=
 =?us-ascii?Q?NG1T0rAX0CkgFL/T5m22mMqx2EdROOkcylQzR/V44Ldg6RMpmRoH3xe7xkdM?=
 =?us-ascii?Q?2R9CWR0zRv53TXp7y+EhsFwmusdT/YlvzhW5GdMjzBlZuKjGG1dqDHV+lJj3?=
 =?us-ascii?Q?LFPsQbbJy18OFUGYVA6zMahPzlz6jec3CEEQDWj3WBqplBb4Z+cLI0+Mc1sx?=
 =?us-ascii?Q?ieedNDfVEn28B1JNpK/mlmxRFJVurdLyBYaMCO7XXt88V6JFg+MmHo3FD2jj?=
 =?us-ascii?Q?cBeVeCpn/ZlyfIWFMPzKZZQn/qN0sOB5mzfdnM/rSnMFr1aqdlqPr2jD5bSj?=
 =?us-ascii?Q?p/DTP8D07uzjgq2+TzixmQyecHzchbyF1rONXU7j3KlUM2QyiMBaI85I+Lp5?=
 =?us-ascii?Q?+wuulX+NSn1g5Mcpk22fxwKxBH3DSmUkSqyqERyJgyOPldYdXhVT8VXZx6we?=
 =?us-ascii?Q?OI2LaoZWnKNef3PxUvQfxlHtJtn8fK3xJhyuS8P9i/kz07FcFWA+JPDTkafD?=
 =?us-ascii?Q?ilMygz01dZpIwsUxQhBhs1Rn5yBwxN8jcgnNkxkrQYxPl470uzp8M2py0Y2L?=
 =?us-ascii?Q?9cA8hOsWXu6zsUthVk72ov/MMDnEAvRQ6bcyvrW6B/i14IbYMUeQw+u/gjt1?=
 =?us-ascii?Q?V1yUOgBoLs2WWOVXGXmIp44uu6sVIba3f1DrEHrD7ZG3cpdWc07lf/g2emGU?=
 =?us-ascii?Q?d3QcPA596Zjs3S0rAsxSvi5n6EvHfQBUEjk5d0aXRB4LFTVjfW3z6/yk+hpP?=
 =?us-ascii?Q?NGHpl3BA8g15FGeJvQj4VlTM/HlVwm/P4/1hRk22aduT6yHfPWukGjQRSKMX?=
 =?us-ascii?Q?Ck2miAnG7spyyxXVDjy4Qyj0zaa2OS+vEUKQ75e8STSuarFMJa2LEENqattK?=
 =?us-ascii?Q?sbd05Yk/fR5qKMiR0UTN0TTFo7WaOU/bGnrxSL1lssCoNhUHkjGtD0XlHeGV?=
 =?us-ascii?Q?OZBC6T9zcj5EkRYH4GibBTaEnhCnNVfjNqP3p241?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f108f46-857d-4f11-399e-08daff24625e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:34:56.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OdPyBaNy5FD/K1AtMLeCluF/6cPPomIZDUA1EIvFp8KwFQkpwDG5Vr+fjGhbel8qZkf40jwRXCEC6KW/cMIWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6106
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support to log and record the CXL poison events.
> 
> The corresponding Kernel patches here:
> https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com/
> 
> Presently RFC draft version for logging, could be extended for the policy
> based recovery action for the frequent poison events depending on the above
> kernel patches.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[snip]

> +
> +int ras_cxl_poison_event_handler(struct trace_seq *s,
> +				 struct tep_record *record,
> +				 struct tep_event *event, void *context)
> +{
> +	int len;
> +	unsigned long long val;
> +	struct ras_events *ras = context;
> +	time_t now;
> +	struct tm *tm;
> +	struct ras_cxl_poison_event ev;
> +
> +	now = record->ts/user_hz + ras->uptime_diff;
> +	tm = localtime(&now);
> +	if (tm)
> +		strftime(ev.timestamp, sizeof(ev.timestamp),
> +			 "%Y-%m-%d %H:%M:%S %z", tm);
> +	else
> +		strncpy(ev.timestamp, "1970-01-01 00:00:00 +0000", sizeof(ev.timestamp));
> +	trace_seq_printf(s, "%s ", ev.timestamp);
> +
> +	ev.memdev = tep_get_field_raw(s, event, "memdev",
> +				      record, &len, 1);
> +	if (!ev.memdev)
> +		return -1;
> +	trace_seq_printf(s, "memdev:%s ", ev.memdev);
> +
> +	ev.pcidev = tep_get_field_raw(s, event, "pcidev",
> +				      record, &len, 1);
> +	if (!ev.pcidev)
> +		return -1;
> +	trace_seq_printf(s, "pcidev:%s ", ev.pcidev);
> +
> +	ev.region = tep_get_field_raw(s, event, "region",
> +				      record, &len, 1);
> +	if (!ev.region)
> +		return -1;
> +	trace_seq_printf(s, "region:%s ", ev.region);
> +
> +	ev.uuid = tep_get_field_raw(s, event, "uuid",
> +				    record, &len, 1);
> +	if (!ev.uuid)
> +		return -1;
> +	trace_seq_printf(s, "region_uuid:%s ", ev.uuid);
> +
> +	if (tep_get_field_val(s, event, "hpa", record, &val, 1) < 0)
> +		return -1;
> +	ev.hpa = val;
> +	trace_seq_printf(s, "poison list: hpa:0x%llx ", (unsigned long long)ev.hpa);
> +
> +	if (tep_get_field_val(s, event, "dpa", record, &val, 1) < 0)
> +		return -1;
> +	ev.dpa = val;
> +	trace_seq_printf(s, "dpa:0x%llx ", (unsigned long long)ev.dpa);
> +
> +	if (tep_get_field_val(s, event, "length", record, &val, 1) < 0)
> +		return -1;
> +	ev.length = val;
> +	trace_seq_printf(s, "length:%d ", ev.length);
> +
> +	if (tep_get_field_val(s,  event, "source", record, &val, 1) < 0)
> +		return -1;
> +
> +	switch (val) {
> +	case CXL_POISON_SOURCE_UNKNOWN:
> +		ev.source = "Unknown";
> +		break;
> +	case CXL_POISON_SOURCE_EXTERNAL:
> +		ev.source = "External";
> +		break;
> +	case CXL_POISON_SOURCE_INTERNAL:
> +		ev.source = "Internal";
> +		break;
> +	case CXL_POISON_SOURCE_INJECTED:
> +		ev.source = "Injected";
> +		break;
> +	case CXL_POISON_SOURCE_VENDOR:
> +		ev.source = "Vendor";
> +		break;
> +	default:
> +		ev.source = "Invalid";
> +	}
> +	trace_seq_printf(s, "source:%s ", ev.source);
> +
> +	if (tep_get_field_val(s,  event, "flags", record, &val, 1) < 0)
> +		return -1;
> +	ev.flags = val;
> +	trace_seq_printf(s, "flags:%d ", ev.flags);
> +
> +	if (ev.flags & CXL_POISON_FLAG_OVERFLOW) {
> +		if (tep_get_field_val(s,  event, "overflow_t", record, &val, 1) < 0)
> +			return -1;
> +		if (val) {
> +			/* CXL Specification 3.0
> +			 * Overflow timestamp - The number of unsigned nanoseconds
> +			 * that have elapsed since midnight, 01-Jan-1970 UTC
> +			 */
> +			time_t ovf_ts_secs = val / 1000000000ULL;
> +
> +			tm = localtime(&ovf_ts_secs);
> +			if (tm) {
> +				strftime(ev.overflow_ts, sizeof(ev.overflow_ts),
> +					 "%Y-%m-%d %H:%M:%S %z", tm);
> +			}
> +		}
> +		if (!val || !tm)
> +			strncpy(ev.overflow_ts, "1970-01-01 00:00:00 +0000",
> +				sizeof(ev.overflow_ts));
> +	} else
> +		strncpy(ev.overflow_ts, "1970-01-01 00:00:00 +0000", sizeof(ev.overflow_ts));
> +	trace_seq_printf(s, "overflow timestamp:%s ", ev.overflow_ts);
> +	trace_seq_printf(s, "\n");
> +
> +	/* Insert data into the SGBD */
> +#ifdef HAVE_SQLITE3
> +	ras_store_cxl_poison_event(ras, &ev);
> +#endif

I know nothing about the rasdaemon build system but it seems like this
needs a ifdef HAVE_CXL around it?

[snip]

> --- a/ras-record.c
> +++ b/ras-record.c
> @@ -559,6 +559,67 @@ int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev)
>  }
>  #endif
>  
> +#ifdef HAVE_CXL
> +/*
> + * Table and functions to handle cxl:cxl_poison
> + */
> +static const struct db_fields cxl_poison_event_fields[] = {
> +	{ .name = "id",                   .type = "INTEGER PRIMARY KEY" },
> +	{ .name = "timestamp",            .type = "TEXT" },
> +	{ .name = "memdev",               .type = "TEXT" },
> +	{ .name = "pcidev",               .type = "TEXT" },
> +	{ .name = "region",               .type = "TEXT" },
> +	{ .name = "region_uuid",          .type = "TEXT" },
> +	{ .name = "hpa",                  .type = "INTEGER" },
> +	{ .name = "dpa",                  .type = "INTEGER" },
> +	{ .name = "length",               .type = "INTEGER" },
> +	{ .name = "source",               .type = "TEXT" },
> +	{ .name = "flags",                .type = "INTEGER" },
> +	{ .name = "overflow_ts",          .type = "TEXT" },
> +};
> +
> +static const struct db_table_descriptor cxl_poison_event_tab = {
> +	.name = "cxl_poison_event",
> +	.fields = cxl_poison_event_fields,
> +	.num_fields = ARRAY_SIZE(cxl_poison_event_fields),
> +};
> +
> +int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev)

Because I believe this is not defined if (!HAVE_CXL and HAVE_SQLITE3)

[snip]

>  
>  #ifdef HAVE_SQLITE3
>  
> @@ -155,6 +170,9 @@ struct sqlite3_priv {
>  #ifdef HAVE_MEMORY_FAILURE
>  	sqlite3_stmt	*stmt_mf_event;
>  #endif
> +#ifdef HAVE_CXL
> +	sqlite3_stmt	*stmt_cxl_poison_event;
> +#endif
>  };
>  
>  struct db_fields {
> @@ -182,6 +200,7 @@ int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
>  int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev);
>  int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
>  int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
> +int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
>  
>  #else
>  static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
> @@ -195,6 +214,7 @@ static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_ev
>  static inline int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev) { return 0; };
>  static inline int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
>  static inline int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
> +static inline int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };

But I could be missing something.

Ira

[snip]
