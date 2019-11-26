Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE641109A2B
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 09:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfKZIaD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 03:30:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727164AbfKZIaD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 03:30:03 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 40B66333196AB7F24E7C;
        Tue, 26 Nov 2019 16:30:01 +0800 (CST)
Received: from [127.0.0.1] (10.74.184.86) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 26 Nov 2019
 16:29:52 +0800
Subject: Re: [PATCH 3/9] rasdaemon: decode submodule of OEM type1 for hip08
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <1573561634-225173-1-git-send-email-tanxiaofei@huawei.com>
 <1573561634-225173-4-git-send-email-tanxiaofei@huawei.com>
 <20191126070713.5bc61802@kernel.org>
CC:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5DDCE227.9000105@huawei.com>
Date:   Tue, 26 Nov 2019 16:28:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191126070713.5bc61802@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.184.86]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mauro,

On 2019/11/26 14:07, Mauro Carvalho Chehab wrote:
> Em Tue, 12 Nov 2019 20:27:08 +0800
> Xiaofei Tan <tanxiaofei@huawei.com> escreveu:
> 
>> Decode submodule of OEM type1 for hip08, and reconstruct the functions
>> of geting OEM module name and submodule name.
>>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>

...

>> +		const char *str = oem_module_name(hisi_oem_type1_module,
>> +						  err->module_id);
>> +
>> +		p += snprintf(p, end - p, "module=%s ", str);
> 
> 
> 
> Rasdaemon doesn't build after applying this patch, as "end" doesn't exist
> yet.
> 
> I suspect that a latter patch in this series could be adding it, but
> the better is to not break rasdaemon build on some random patch, as, if
> we ever need to do a git bisect, this would make it harder for it to
> work.
> 

Oh, Yes, this is my fault. I will fix this issue and send v2 patch set after removing two applied. thanks.

> 
>>  		record_vendor_data(dec_tab, hisi_oem_data_type_text,
>>  				   hip08_oem_type1_field_module_id,
>> -				   0, oem_type1_module_name(err->module_id));
>> +				   0, str);
>>  	}
>>  
>>  	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
>> -		char submodule_name[64];
>> +		const char *str = oem_submodule_name(hisi_oem_type1_module,
>> +						     err->module_id,
>> +						     err->sub_module_id);
>>  
>> -		sprintf(submodule_name, "%s%d",
>> -			oem_type1_module_name(err->module_id),
>> -			err->sub_module_id);
>> -		p += sprintf(p, "submodule=%s ", submodule_name);
>> +		p += snprintf(p, end - p, "submodule=%s ", str);
>>  		record_vendor_data(dec_tab, hisi_oem_data_type_text,
>>  				   hip08_oem_type1_field_sub_module_id,
>> -				   0, submodule_name);
>> +				   0, str);
>>  	}
>>  
>>  	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
>> @@ -596,18 +749,21 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
>>  	}
>>  
>>  	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
>> -		p += sprintf(p, "module=%s ",
>> -			     oem_type2_module_name(err->module_id));
>> +		const char *str = oem_module_name(hisi_oem_type2_module,
>> +						  err->module_id);
>> +
>> +		p += snprintf(p, end - p, "module=%s ", str);
>>  		record_vendor_data(dec_tab, hisi_oem_data_type_text,
>>  				   hip08_oem_type2_field_module_id,
>> -				   0, oem_type2_module_name(err->module_id));
>> +				   0, str);
>>  	}
>>  
>>  	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
>> -		const char *str = oem_type2_sub_module_name(err->module_id,
>> -							    err->sub_module_id);
>> +		const char *str = oem_submodule_name(hisi_oem_type2_module,
>> +						     err->module_id,
>> +						     err->sub_module_id);
>>  
>> -		p += sprintf(p, "submodule=%s ", str);
>> +		p += snprintf(p, end - p, "submodule=%s ", str);
>>  		record_vendor_data(dec_tab, hisi_oem_data_type_text,
>>  				   hip08_oem_type2_field_sub_module_id,
>>  				   0, str);
> 
> 
> 
> 
> Cheers,
> Mauro
> 
> .
> 

-- 
 thanks
tanxiaofei

