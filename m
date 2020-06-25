Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127D920A2D4
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jun 2020 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbgFYQ03 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Jun 2020 12:26:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47530 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389522AbgFYQ03 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Jun 2020 12:26:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PG7qRB176249;
        Thu, 25 Jun 2020 16:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=u+J0urSX+VPS0JEyukwvvQzOKq9cJrq+hfdXkn5ldnA=;
 b=n1zHCoNMnP6ZR3D0Xc25mVn17UPByoYPvWFElhYxTDlZMEj9pT3Nx98VHF+SDfbXjuv5
 3UBy/XijDQQ3fpqbgIfDEq8tI+cqYaOnAbUuI8wsftkhaODK9gpL/uhz87RFzVxQIMk1
 1B94FDBYPiR1BE4ObjHcKo4fwWiJivmpbk1oNhS99c/pX8N406zxLMTwXeuvOlidIzoV
 4gcYPLzhTFn5DfzgixJA4/sORyEYZQWNweZz6fzR8O8Lqiev1kNksh0gVQ9UskyQjsvG
 bY3irJkjm8IvjcYg66s4dbzxGX+MGVDGREZWPJsN7rA4bdh5E9GUzjtcng1r9LUfBBS7 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31uustsh3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jun 2020 16:26:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PG9ROi063312;
        Thu, 25 Jun 2020 16:24:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31uurssrh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 16:24:07 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05PGO31n003645;
        Thu, 25 Jun 2020 16:24:03 GMT
Received: from [10.159.156.197] (/10.159.156.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jun 2020 16:24:03 +0000
Subject: Re: [RFC] Make the memory failure blast radius more precise
To:     "Luck, Tony" <tony.luck@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
 <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
 <20200623224027.GI21350@casper.infradead.org>
 <24367ca1-ecb0-de96-b9e5-f94747838c74@oracle.com>
 <3908561D78D1C84285E8C5FCA982C28F7F67BB29@ORSMSX115.amr.corp.intel.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <5aecb2f9-413f-acbb-f2ea-be75589725c6@oracle.com>
Date:   Thu, 25 Jun 2020 09:23:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F67BB29@ORSMSX115.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250102
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/24/2020 5:13 PM, Luck, Tony wrote:
>> Both the RFC patch and the above 5-step recovery plan look neat, step 4)
>> is nice to carry forward on icelake when a single instruction to clear
>> poison is available.
> 
> Jane,
> 
> Clearing poison has some challenges.
> 
> On persistent memory it probably works (as the DIMM is going to remap that address to a different
> part of the media to avoid the bad spot).
> 
> On DDR memory you'd need to decide whether the problem was transient, so that a simple
> overwrite fixes the problem. Or persistent ... in which case the problem will likely come back
> with the right data pattern.  To tell that you may need to run some memory test on the affected
> area.
> 
> If the error was just in a 4K page, I'd be inclined to copy the good data to a new page and
> map that in instead. Throwing away one 4K page isn't likely to be painful.
> 
> If it is in a 2M/1G page ... perhaps it is worth the effort and risk of trying to clear the poison
> in place to avoid the pain of breaking up a large page.

Thanks!  Yes I was only thinking about persistent memory, but 
memory_failure_dev_pagemap() applies to DDR as well depends on the 
underlying technology. In our use case, even if the error was just in a 
4K page, we'd like to clear the poison and reuse the page to maintain a 
contiguous 256MB extent in the filesystem.  Perhaps it is better to 
leave that to the filesystem and driver.

Regards,
-jane

> 
> -Tony
> 
