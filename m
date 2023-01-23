Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157F4677AB5
	for <lists+linux-edac@lfdr.de>; Mon, 23 Jan 2023 13:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAWMWm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Jan 2023 07:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAWMWl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 Jan 2023 07:22:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E705599;
        Mon, 23 Jan 2023 04:22:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0q0Z50mvz6J6Xr;
        Mon, 23 Jan 2023 20:19:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 12:22:39 +0000
Date:   Mon, 23 Jan 2023 12:22:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <shiju.jose@huawei.com>
CC:     <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mchehab@kernel.org>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 3/4] rasdaemon: Add support for the CXL AER
 uncorrectable errors
Message-ID: <20230123122238.00006599@Huawei.com>
In-Reply-To: <20230119171809.1406-4-shiju.jose@huawei.com>
References: <20230119171809.1406-1-shiju.jose@huawei.com>
        <20230119171809.1406-4-shiju.jose@huawei.com>
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

On Thu, 19 Jan 2023 17:18:08 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support to log and record the CXL AER uncorrectable errors.
> 
> The corresponding Kernel patch here:
> https://patchwork.kernel.org/project/cxl/patch/166974413388.1608150.5875712482260436188.stgit@djiang5-desk3.ch.intel.com/
> 
> Note: It was found that the header log data to be converted to the
>       big-endian format to correctly store in the SQLite database, likely
>       because the SQLite database seems uses the big-endian storage.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I don't like the endian conversion stuff, but can't come up
with a better way to deal with SQLs lack of elegant storage for
arrays of data (kind of fair enough as why would you have
arrays in a DB? :).  Ah well!

