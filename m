Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1618C3C
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEIOrS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 10:47:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47776 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfEIOrS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 May 2019 10:47:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49EcgWo195704;
        Thu, 9 May 2019 14:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=9KdASKqT+bX6dnzKqWHQ8nRW8LyG9PhxOkKq1U8oUqo=;
 b=t2YTCXO/Tab860M6f0bbVOT1ax9U6R6IQs3ZlgoN2ls7GTc8Fgw7eM+rHhVYnTuBt6QH
 8uyKB3K8BwuWfozyMb8puqoRxPMFHboSFlpC1B0Z2BYBUhTBVbz50EN3cvLJc4/tPxfT
 uYfRCZV4FkY5oDIdIxlNEjd7/S/negFkd5HtYJLpSNEZNbgLSbLqdOGoJsb+zaXWg4gN
 P0Pf2TdbntyPKRgvcmGYSY4/a5UjlNzhlOpNIjhdopKdE/r/1fXCGHHleTQFWhBPZEKc
 A7JIPdeXJ2auaBxKziulQURaRPpKY1CqZrOgSe9tRHh8a4zkIUEWNJkeDsWhkz/7/cxJ Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s94bgbcaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 14:47:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49El6Sf060409;
        Thu, 9 May 2019 14:47:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2s94batxcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 14:47:06 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49El1fc015112;
        Thu, 9 May 2019 14:47:01 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 07:46:58 -0700
Date:   Thu, 9 May 2019 17:46:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Tony Luck <tony.luck@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, sb_edac: remove redundant update of tad_base
Message-ID: <20190509144650.GG21059@kadam>
References: <20190508224201.27120-1-colin.king@canonical.com>
 <20190509141313.GA17053@zn.tnic>
 <55f8efee-a02c-1574-42fa-35e1d3df14f7@canonical.com>
 <20190509144113.GB17053@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509144113.GB17053@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090086
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090086
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 09, 2019 at 04:41:13PM +0200, Borislav Petkov wrote:
> Bottom line of what I'm trying to say is, those tags better be useful to
> the general kernel audience - that means, they should be documented so
> that people can look them up - or better not be in commit messages at
> all.

Other people will complain if you don't mention the tool name...

You can't win.  :(

regards,
dan carpenter

