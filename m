Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092DD677AAF
	for <lists+linux-edac@lfdr.de>; Mon, 23 Jan 2023 13:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjAWMVP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Jan 2023 07:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAWMVO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 Jan 2023 07:21:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD275599;
        Mon, 23 Jan 2023 04:21:13 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0pyt6LyCz67QJq;
        Mon, 23 Jan 2023 20:17:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 12:21:11 +0000
Date:   Mon, 23 Jan 2023 12:21:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <shiju.jose@huawei.com>
CC:     <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mchehab@kernel.org>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 2/4] rasdaemon: Add support for the CXL poison
 events
Message-ID: <20230123122110.000002cc@Huawei.com>
In-Reply-To: <20230119171809.1406-3-shiju.jose@huawei.com>
References: <20230119171809.1406-1-shiju.jose@huawei.com>
        <20230119171809.1406-3-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 19 Jan 2023 17:18:07 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support to log and record the CXL poison events.
> 
> The corresponding Kernel patches here:
> https://lore.kernel.org/lkml/cover.1668115235.git.alison.schofield@intel.com/
> 
> Presently RFC draft version for logging, could be extended for the policy
> based recovery action for the frequent poison events depending on the above
> kernel patches.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

There may be some room to clean up rasdaemon in general given
Mauro has moved it to upstream libtraceevent in last few days,
but that is a topic for another day.
I'm not that keen on some of the SQL in rasdaemon (too many strings
for enums etc that make the DBs inelegant!), but what you have here
is in line with existing practice.

LGTM now Alison's question is resolved.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan
